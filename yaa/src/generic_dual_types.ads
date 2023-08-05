generic
type Real is digits <>;
package Generic_Dual_Types is
   pragma Pure (Generic_Dual_Types);

   type Dual is
   record
      Re, Im1, Im2, Im12 : Real'Base;
   end record;

   function Re (D : Dual) return Real'Base;
   function Im1 (D : Dual) return Real'Base;
   function Im2 (D : Dual) return Real'Base;
   function Im12 (D : Dual) return Real'Base;

   procedure Set_Re (D  : in out Dual;
                     V : in     Real'Base)
      with Post => (D.Re = V and D.Im1 = D'Old.Im1 and
                     D.Im2 = D'Old.Im2 and D.Im12 = D'Old.Im12);
   procedure Set_Im1 (D  : in out Dual;
                     V : in     Real'Base)
      with Post => (D.Re = D'Old.Re and D.Im1 = V and
                     D.Im2 = D'Old.Im2 and D.Im12 = D'Old.Im12);
   procedure Set_Im2 (D  : in out Dual;
                     V : in     Real'Base)
      with Post => (D.Re = D'Old.Re and D.Im1 = D'Old.Im1 and
                     D.Im2 = V and D.Im12 = D'Old.Im12);
   procedure Set_Im12 (D  : in out Dual;
                     V : in     Real'Base)
      with Post => (D.Re = D'Old.Re and D.Im1 = D'Old.Im1 and
                     D.Im2 = D'Old.Im2 and D.Im12 = V);

   function "-" (D : in Dual) return Dual;

   function "+" (D1, D2 : in Dual) return Dual;
   function "-" (D1, D2 : in Dual) return Dual;
   function "*" (D1, D2 : in Dual) return Dual;

   function "/" (D1, D2 : in Dual) return Dual
         with Pre => D2.Re /= 0.0;

   function "*" (D : in Dual; R : in Real) return Dual;
   function "*" (R : in Real; D : in Dual) return Dual;

   function To_Dual (R : in Real) return Dual;

   function Image (D : in Dual) return String;

   Dual_Zero : Dual := (0.0, 0.0, 0.0, 0.0);
   Dual_One : Dual := (1.0, 0.0, 0.0, 0.0);

end Generic_Dual_Types;