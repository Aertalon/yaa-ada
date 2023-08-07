--  SPDX-License-Identifier: Apache-2.0
--
--  Copyright (c) 2023 ELovisari <elovisari@gmail.com>
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.

with AUnit.Reporter.Text;
with AUnit.Run;
with AUnit.Test_Suites;

with Test_Duals;
with Test_Yaa;

procedure Test_Bindings is
   function Suite return AUnit.Test_Suites.Access_Test_Suite;

   function Suite return AUnit.Test_Suites.Access_Test_Suite is
      Result : constant AUnit.Test_Suites.Access_Test_Suite :=
      AUnit.Test_Suites.New_Suite;
   begin
      Result.Add_Test (Test_Duals.Suite);
      Result.Add_Test (Test_Yaa.Suite);

      return Result;
   end Suite;

   procedure Runner is new AUnit.Run.Test_Runner (Suite);

   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Reporter.Set_Use_ANSI_Colors (True);
   Runner (Reporter);
end Test_Bindings;
