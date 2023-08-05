with AUnit.Assertions;
with AUnit.Test_Caller;

package body Test_Dummy is

   use AUnit.Assertions;

   package Caller is new AUnit.Test_Caller (Test);

   Test_Suite : aliased AUnit.Test_Suites.Test_Suite;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Name : constant String := "(Dummies) ";
   begin
      Test_Suite.Add_Test (Caller.Create
      (Name & "Dummy test 1", Test_Dummy_1'Access));
      Test_Suite.Add_Test (Caller.Create
      (Name & "Dummy test 2", Test_Dummy_2'Access));

      return Test_Suite'Access;
   end Suite;

   procedure Test_Dummy_1 (Object : in out Test) is
   begin
      Assert (True, "Dummy 1");
   end Test_Dummy_1;

   procedure Test_Dummy_2 (Object : in out Test) is
   begin
      Assert (True, "Dummy 2");
   end Test_Dummy_2;

end Test_Dummy;
