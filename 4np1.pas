(* Author: Sam Dobesh      *)
(* Due Date: Fri, Jan 29th *)
(* Desc: Prime factorizer  *)
(* implemented in pascal.  *)
(* ------------------------------------------------------------------------ 80*)
program factored_primes;

  type
    (* array type for holding prime set *)
    intarray = array of Longint;

  var
    input: Longint;    (* to catch input *)
    primes : intarray; (* to collect primes *)
    j : Longint;       (* to hold our place in primes list *)


  (* ISPRIME *)
  (* function to test primeness of a single number n *)
  function isprime(n : Longint) : Boolean;
    var
      i : Longint;

    begin
      i := 0;
      (* Don't check more primes than we have, don't check past sqrt *)
      while ((i < j) and (primes[i] * primes[i] <= n)) do
        begin
          if (n mod primes[i]) = 0 then
            exit(false)
          else
            i := i + 2;
        end;
      (* if we escaped this loop before returning, it's prime *)
      exit(true);
    end;


  (* TWOROOTS *)
  (* find the square factors for a single number *)
  procedure tworoots(n : Longint; var f1, f2: Longint);
  var
    remaining : Longint;
    i : Longint;
    j : Longint;

  begin
    for i := 1 to n do
      begin
        remaining := n - (i * i);
        for j := 1 to n do
          if remaining - (j * j) = 0 then
            begin
              f1 := i;
              f2 := j;
              exit();
            end;
      end;
  end;


  (* GEN_PRIMES_TO *)
  (* generate factored primes up to a given number n *)
  function gen_primes_to(n : Longint) : intarray;
    var
      new_prime : Longint;       (* next possible prime *)
      f1 : Longint;            (* factor 1 *)
      f2 : Longint;            (* factor 2 *)

    begin
      (* if n is small or neg return empty list *)
      if (n <= 1) then
        begin
          setlength(primes, 0);
          gen_primes_to := primes;
        end
      (* Otherwise *)
      else
        begin
          setlength(primes, (n div 2) + 1);     (* set length to a safe value *)
          primes[0] := 2;                    (* First prime is 2, that's easy *)
          j := 1;                             (* global index for primes list *)
          new_prime := 3;                              (* first prime to test *)

          (* stop calculating when new prime is more than n *)
          while (new_prime <= n) do
            begin
              (* pass each number into isprime *)
              if isprime(new_prime) then
                begin
                  (* add to list of known primes *)
                  primes[j] := new_prime;

                  (* factor primes in set 4n+1 *)
                  if (new_prime - 1) mod 4 = 0 then
                    begin
                    tworoots(new_prime, f1, f2);
                    writeln(new_prime, ' ', f1, ' ', f2);
                    end;

                  (* next number to check *)
                  new_prime := primes[j] + 1;
                  j := j + 1;
                end
              (* otherwise, don't add it and check next number *)
              else
                new_prime := new_prime + 2;
            end;

          (* remove trailing 0s before returning *)
          setlength(primes, j);
          (* return *)
          gen_primes_to := primes;
        end;
    end;


  (* MAIN *)
  begin
    readln(input);
    gen_primes_to(input);
  end.
