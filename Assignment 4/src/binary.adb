-- Binary package implementation

with Ada.Text_IO, Ada.Integer_Text_IO, Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

package body Binary is

   -- FUNCTIONS

   -- Generates a random 16-bit array
   function Generate_Array return BINARY_ARRAY is

      package My_Random is new Random(FLOAT);
      use My_Random;

      Random_Array : BINARY_ARRAY := (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1);

   begin
      Set_Seed;

   while Bin_To_Int(Random_Array) > 32767 loop --Limits integer values since there's only 16-bits
      for Index in Random_Array'Range loop
         Random_Array(Index) := BINARY_NUMBER(Random_Number);
      end loop;
   end loop;

      return Random_Array;

   end Generate_Array;

   -- Converts binary array into integer.
   function Bin_To_Int(Array_In : BINARY_ARRAY) return Integer is
      Exponent : Integer := 0;
      Conversion : Integer := 0;
   begin
      for Index in reverse Array_In'Range loop
         Conversion := Conversion + (Integer(Array_In(Index)) * (2 ** Exponent));
         Exponent := Exponent + 1;
         end loop;
      return Conversion;
   end Bin_To_Int;

   -- Converts integer into 16-bit binary array.
   function Int_To_Bin(Int_In : Integer) return BINARY_ARRAY is
      Conversion : BINARY_ARRAY := (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
      Int : Integer := Int_In;
   begin
      for Index in reverse Conversion'Range loop
         if Int mod 2 = 0 then
            Conversion(Index) := 0;
            Int := Int / 2;

         else
            Conversion(Index) := 1;
            Int := (Int - 1) / 2;
         end if;

      end loop;

      return Conversion;
   end Int_To_Bin;

   -- "+" operator overload that adds two BINARY_ARRAYs and returns a BINARY_ARRAY as a result.
   function "+"(First_Array, Second_Array : BINARY_ARRAY) return BINARY_ARRAY is
   begin
      return Int_To_Bin(Bin_To_Int(First_Array) + Bin_To_Int(Second_Array));
   end "+";

   -- "+" operator that accepts a BINARY_ARRAY and an integer and return a BINARY_ARRAY as a result.
   function "+"(Array_In : BINARY_ARRAY; Int_In : Integer) return BINARY_ARRAY is
   begin
      return Int_To_Bin(Bin_To_Int(Array_In) + Int_In);
   end "+";

   -- "-" operator overload that adds two BINARY_ARRAYs and returns a BINARY_ARRAY as a result.
   function "-"(First_Array, Second_Array : BINARY_ARRAY) return BINARY_ARRAY is
   begin
      return Int_To_Bin(Bin_To_Int(First_Array) - Bin_To_Int(Second_Array));
   end "-";

    -- "-" operator that accepts a BINARY_ARRAY and an integer and return a BINARY_ARRAY as a result.
   function "-"(Array_In : BINARY_ARRAY; Int_In : Integer) return BINARY_ARRAY is
   begin
      return Int_To_Bin(Bin_To_Int(Array_In) - Int_In);
   end "-";

   -- PROCEDURES

   -- Accepts a BINARY_ARRAY and simply reverses it.
   procedure Reverse_Bin_Arr(Array_In : BINARY_ARRAY) is
   begin
      for Index in reverse Array_In'Range loop
          if Index < 15 and (Index + 1) mod 4 = 0 then
            Put(' ');
            end if;
         Put(Integer(Array_In(Index)), 1);
      end loop;
   end Reverse_Bin_Arr;

   -- Accepts a BINARY_ARRAY and prints it to the console.
   procedure Print_Bin_Arr(Array_In :BINARY_ARRAY) is
   begin
      for Index in Array_In'Range loop
          if Index > 0 and Index mod 4 = 0 then
            Put(' ');
            end if;
         Put(Integer(Array_In(Index)), 1);
      end loop;

   end Print_Bin_Arr;

   end Binary;

