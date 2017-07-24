with IO; use IO;

package body cash_register
with SPARK_Mode is

   procedure payment(pumpunit: in out unit.pump_unit; pump_num: in out pump.pump; amount: in pump.float_number) is
      id: unit.unit_id;
      money: pump.float_number;
      charge: pump.float_number;
      use all type pump.state;
      use all type pump.float_number;
   begin
      id := unit.get_id(pumpunit);
      money:= unit.get_pay(pumpunit);
      if pumpunit.current_state /=pump.Waiting then
         print("Please return the nozzle firstly.");
      else
         print("Your unit id is: "&cashregister.unit1.id);
         print_float("Please pay: ",money);
         print_float("Actually given: ",amount);
         if id= cashregister.unit1.id and unit.get_pay(pumpunit)/=0.0 then
            if amount>=money then
               charge:= amount-money;
               print_float("Your charge is: ", charge);
               cashregister.unit1.pay:=0.00;
               cashregister.unit1.fuel_amount:=0.00;
               pump.set_state(pump_num,pump.state'Val(0));
               pump.set_fuel_amount(pump_num,0.00);
               unit.set_is_paid(pumpunit);
               unit.set_fuel_amount(pumpunit,0.00);
               unit.set_pay(pumpunit,0.00);
            else
               print("Please pay the correct money.");
            end if;
         elsif unit.get_pay(pumpunit)=0.00 then
            print("This unit has already been paid");
         end if;
      end if;
   end payment;

   procedure pump_info (pumpunit: in unit.pump_unit) is
      money: pump.float_number;
      pumpunitid: pump_unit_id;
   begin
      money:=unit.get_pay(pumpunit);
      pumpunitid.id:=unit.get_id(pumpunit);
      pumpunitid.pay:=money;
      pumpunitid.fuel_amount:=unit.get_fuel_amount(pumpunit);
      pumpunitid.fuel:=unit.get_fuel(pumpunit);
      cashregister.unit1:=pumpunitid;
      print("The unit information has registered into the casher.");
   end pump_info;
end cash_register;
