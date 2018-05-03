--ads File for Binary package. Used to create binary integers and arrays as well as add/subtract them.

package Binary is

   -- TYPES
   type BINARY_NUMBER is range 0..1;
   type BINARY_ARRAY is array(0..15) of BINARY_NUMBER;

   --FUNCTIONS
   function Generate_Array return BINARY_ARRAY;
   function Bin_To_Int(Array_In : BINARY_ARRAY) return Integer;
   function Int_To_Bin(Int_In : Integer) return BINARY_ARRAY;
   function "+"(First_Array, Second_Array : BINARY_ARRAY) return BINARY_ARRAY;
   function "+"(Array_In : BINARY_ARRAY; Int_In : Integer) return BINARY_ARRAY;
   function "-"(First_Array, Second_Array : BINARY_ARRAY) return BINARY_ARRAY;
   function "-"(Array_In : BINARY_ARRAY; Int_In : Integer) return BINARY_ARRAY;

   --PROCEDURES
   procedure Reverse_Bin_Arr(Array_In : BINARY_ARRAY);
   procedure Print_Bin_Arr(Array_In :BINARY_ARRAY);

end Binary;
