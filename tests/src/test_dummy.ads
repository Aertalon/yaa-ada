with AUnit.Test_Suites;
with AUnit.Test_Fixtures;

package Test_Dummy is

   function Suite return AUnit.Test_Suites.Access_Test_Suite;

private

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   --  Dummy tests
   procedure Test_Dummy_1 (Object : in out Test);
   procedure Test_Dummy_2 (Object : in out Test);

end Test_Dummy;
