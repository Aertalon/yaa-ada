package body Generic_Dual_Types is

   function Re (D : Dual)   return Real'Base is
   begin
      return D.Re;
   end Re;

   function Im1 (D : Dual)   return Real'Base is
   begin
      return D.Im1;
   end Im1;

   function Im2 (D : Dual)   return Real'Base is
   begin
      return D.Im2;
   end Im2;

   function Im12 (D : Dual)   return Real'Base is
   begin
      return D.Im12;
   end Im12;

   procedure Set_Re (D  : in out Dual;
                     V : in     Real'Base) is
   begin
      D.Re := V;
   end Set_Re;

   procedure Set_Im1 (D  : in out Dual;
                     V : in     Real'Base) is
   begin
      D.Im1 := V;
   end Set_Im1;

   procedure Set_Im2 (D  : in out Dual;
                     V : in     Real'Base) is
   begin
      D.Im2 := V;
   end Set_Im2;

   procedure Set_Im12 (D  : in out Dual;
                     V : in     Real'Base) is
   begin
      D.Im12 := V;
   end Set_Im12;

   function "-" (D : in Dual) return Dual is
   begin
      return (
         Re    => -D.Re,
         Im1   => -D.Im1,
         Im2   => -D.Im2,
         Im12  => -D.Im12);
   end "-";

   function "+" (D1, D2 : in Dual) return Dual is
   begin
      return (
         Re    => D1.Re  + D2.Re,
         Im1   => D1.Im1 + D2.Im1,
         Im2   => D1.Im2 + D2.Im2,
         Im12  => D1.Im12 + D2.Im12);
   end "+";

   function "-" (D1, D2 : in Dual) return Dual is
   begin
      return (
         Re    => D1.Re  - D2.Re,
         Im1   => D1.Im1 - D2.Im1,
         Im2   => D1.Im2 - D2.Im2,
         Im12  => D1.Im12 - D2.Im12);
   end "-";

   function "*" (D1, D2 : in Dual) return Dual is
   begin
      return (
         Re    => D1.Re * D2.Re,
         Im1   => D1.Im1 * D2.Re + D1.Re * D2.Im1,
         Im2   => D1.Im2 * D2.Re + D1.Re * D2.Im2,
         Im12  => D1.Im12 * D2.Re + D1.Re * D2.Im12
                     + D1.Im2 * D2.Im1 + D1.Im1 * D2.Im2);
   end "*";

   function "/" (D1, D2 : in Dual) return Dual is
      A0 : Real renames D1.Re;
      A1 : Real renames D1.Im1;
      A2 : Real renames D1.Im2;
      A12 : Real renames D1.Im12;

      B0 : Real renames D2.Re;
      B1 : Real renames D2.Im1;
      B2 : Real renames D2.Im2;
      B12 : Real renames D2.Im12;
   begin
      return (
         Re    => A0 / B0,
         Im1   => (A1 * B0  - A0 * B1) / B0 ** 2,
         Im2   => (A2 * B0 - A0 * B2) / B0 ** 2,
         Im12  => (
            A12 * B0 * B0 - A0 * B0 * B12
               - A2 * B0 * B1 - A1 * B0 * B2
               + A0 * B1 * B2 + A0 * B1 * B2) / B0 ** 3);
   end "/";

   function "*" (D : in Dual; R : in Real) return Dual is
   begin
      return (
         Re    => R * D.Re,
         Im1   => R * D.Im1,
         Im2   => R * D.Im2,
         Im12  => R * D.Im12);
   end "*";

   function "*" (R : in Real; D : in Dual) return Dual is
   begin
      return D * R;
   end "*";

   function To_Dual (R : in Real) return Dual is
   begin
      return (
         Re => R,
         others => 0.0
      );
   end To_Dual;

   function Image (D : in Dual) return String is
   begin
      return "(" &
         Real'Image (D.Re) & ", " &
         Real'Image (D.Im1) & ", " &
         Real'Image (D.Im2) & ", " &
         Real'Image (D.Im12) & ")";
   end Image;

end Generic_Dual_Types;