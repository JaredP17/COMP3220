with Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO, Random;
use Ada.Text_IO, Ada.Float_Text_IO, Ada.Integer_Text_IO;

procedure Main is

   package My_Random is new Random(FLOAT);
   use My_Random;

   A_Number: INTEGER;
begin
   Set_Seed;
   Put(Random_Number,3,6,0);
   A_Number := INTEGER(FLOAT(Random_Number) * FLOAT(10));
   New_Line(1);
   Put(A_Number);
end Main;

--generates a single random number between 0 and 10
