with pump;
with unit;
with cash_register;
with IO; use IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use  Ada.Integer_Text_IO;

procedure main is
   use all type pump.state;
   use all type pump.fuel_types;
   use all type pump.float_number;

   --Pump Unit:
   unit1 : unit.pump_unit;

   --Pumps:
   unit1_91: pump.pump;
   unit1_95: pump.pump;
   unit1_Diesel: pump.pump;

   --Fuel types:
   F91: pump.fuel_types;
   F95: pump.fuel_types;
   Diesel: pump.fuel_types;

   --The value of Fuel types:
   U_F91: Integer :=0;
   U_F95: Integer :=1;
   U_Diesel: Integer :=2;

   --The value of Pump state:
   Base: Integer := 0;
   Ready: Integer := 1;
   Pumping: Integer := 2;
   Waiting: Integer := 3;

   --The value of nozzle state:
   Initial: Integer := 0;
   Left: Integer := 1;
   Replace: Integer := 2;
   Start: Integer := 3;
   Stop : Integer := 4;
   Pay: Integer:=5;

   car_space: pump.float_number:=1000.00;    --The currently available space for fuel of a car
   amount_to_fill: pump.float_number;     --The required pumping amount:
   isTest: Boolean;     -- a variable determining the type of testing

   input_unit: String(1..5);  --input value of unit
   input_fuel_types: String(1..3);  --input value of fuel types
   input_amount: Integer;  --input value of pumping amount

begin
   --Assigning fuel types:
   F91 :=pump.fuel_types'Val(U_F91);
   F95 :=pump.fuel_types'Val(U_F95);
   Diesel :=pump.fuel_types'Val(U_Diesel);

   --Setting the unit and adding three pumps, the result is in the following:
   unit.set_id(unit1, "unit1");
   unit.add_pump(unit1, unit1_91,F91);
   unit.add_pump(unit1, unit1_95,F95);
   unit.add_pump(unit1, unit1_Diesel,Diesel);

   --Assigning the pumps to the unit:
   unit1_91:=unit.get_pump(unit1,F91);
   unit1_95:=unit.get_pump(unit1,F95);
   unit1_Diesel:=unit.get_pump(unit1,Diesel);

   isTest := False;
   if isTest = False then
      print("Test");
      car_space := 5.00;
      amount_to_fill := 5.00;
      unit.lift_nozzle(unit1, unit1_95,F95);
      --test pumping
      print("Test scenarios: Pumping for a predetermined amount of fuel");
      unit.start_pumping(unit1,unit1_95,amount_to_fill,car_space);
      unit.replace_nozzle(unit1,unit1_95);
      New_Line(1);
      --send info to the cashier
      print("Test scenarios: Sending the unit information to the cashier");
      cash_register.pump_info(unit1);
      New_Line(1);
      --pay
      print("Test scenarios: Printing the payment information");
      --cash_register.payment(unit1,unit1_95,unit.get_pay(unit1));
      cash_register.payment(unit1,unit1_95,50.00);
      --unit.lift_nozzle(unit1, unit1_91,F91);
      print("Test finished");

   else
      print("please select an unit, required format('unit1')");
      if unit.is_occupied(unit1) =False then
         print("unit1 is available");
      end if;
      put("Enter: ");
      get(input_unit);
      if input_unit = unit.get_id(unit1) and unit.is_occupied(unit1) =False then
         print("please select a fuel type, required format('F91, F95, Die')");
         put("Enter: ");
         get(input_fuel_types);
         if input_fuel_types = "F91" or input_fuel_types = "F95" or input_fuel_types = "Die" then
            print("please input pumping amount:");
            put("Enter: ");
            get(input_amount);
            if input_amount>=0 then
               if input_fuel_types = "F91" then
                  unit.lift_nozzle(unit1,unit1_91,F91);
                  unit.start_pumping(unit1,unit1_91,pump.float_number(input_amount),car_space);
                  unit.replace_nozzle(unit1,unit1_91);
               elsif input_fuel_types ="F95" then
                  unit.lift_nozzle(unit1,unit1_95,F95);
                  unit.start_pumping(unit1,unit1_95,pump.float_number(input_amount),car_space);
                  unit.replace_nozzle(unit1,unit1_95);
               elsif input_fuel_types = "Die" then
                  unit.lift_nozzle(unit1,unit1_Diesel,Diesel);
                  unit.start_pumping(unit1,unit1_Diesel,pump.float_number(input_amount),car_space);
                  unit.replace_nozzle(unit1,unit1_Diesel);
               end if;
            else
               print("please correctly input amount");
            end if;
         end if;
      end if;
   end if;
end Main;
