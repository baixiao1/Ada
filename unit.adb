with pump;
with IO; use IO;
package body unit is

    procedure set_is_occupied(unit: in out pump_unit) is
   begin
      if pump.get_state(unit.pump_91)=pump.state'Val(0) and pump.get_state(unit.pump_95)=pump.state'Val(0) and pump.get_state(unit.pump_Diesel)=pump.state'Val(0) then
         unit.is_occupied:=False;
         print("The pump unit is not ocuupied now.");
      end if;
   end set_is_occupied;

   procedure set_is_paid(unit: in out pump_unit) is
   begin
      if pump.get_state(unit.pump_91)= pump.state'Val(0)
        and pump.get_state(unit.pump_95)= pump.state'Val(0)
        and pump.get_state(unit.pump_Diesel)= pump.state'Val(0)
      then unit.is_paid:= True;
           print("The pump unit has been paid.");
      end if;
   end set_is_paid;

   procedure set_pay(unit: in out pump_unit; amount: in pump.float_number) is
   begin
      unit.pay:=amount;
   end set_pay;

   procedure set_id(unit: in out pump_unit; id: in unit_id) is
   begin
      unit.id := id;
   end set_id;

   procedure set_fuel_amount(unit: in out pump_unit; amount: in pump.float_number) is
   begin
      unit.fuel_amount:=amount;
   end set_fuel_amount;

   procedure set_current_state(unit: in out pump_unit; fueltype: in pump.fuel_types; state: in  pump.state) is
   begin
      if pump.fuel_types'Pos(fueltype)=0 then unit.avaliable_fuel:=fueltype;
         pump.set_state(unit.pump_91,state);
         elsif pump.fuel_types'Pos(fueltype)=1 then unit.avaliable_fuel:=fueltype;
         pump.set_state(unit.pump_95,state);
         elsif pump.fuel_types'Pos(fueltype)=2 then unit.avaliable_fuel:=fueltype;
         pump.set_state(unit.pump_Diesel,state);
      end if;
   end set_current_state;

   procedure set_nozzle_state(unit: in out pump_unit; fueltype: in pump.fuel_types; nozzletype: in pump.nozzle) is
   begin
         if pump.fuel_types'Pos(fueltype)=0 then unit.nozzle_state:=nozzletype;
         pump.set_nozzle_state(unit.pump_91,nozzletype);
         elsif pump.fuel_types'Pos(fueltype)=1 then unit.nozzle_state:=nozzletype;
         pump.set_nozzle_state(unit.pump_95,nozzletype);
         elsif pump.fuel_types'Pos(fueltype)=2 then unit.nozzle_state:=nozzletype;
         pump.set_nozzle_state(unit.pump_Diesel,nozzletype);
      end if;
   end set_nozzle_state;

   procedure add_pump(unit: in out pump_unit;pump_num : in out pump.pump; fueltype: in pump.fuel_types) is
      begin
      case fueltype is
         when pump.F91 =>
            print("add pump: 91");
            pump.set_price(pump_num, 1.80);
            pump.set_state(pump_num, pump.state'Val(0));
            pump.set_nozzle_state(pump_num,pump.nozzle'Val(0));
            pump.set_reservoir(pump_num, fueltype);
            pump.set_reservoir_size(pump_num, 1000.00);
            unit.pump_91:= pump_num;
            unit.is_occupied := False;
            unit.is_paid:= True;
            unit.pay :=0.00;
            unit.fuel_amount:= 0.00;
            unit.current_state := pump.state'Val(0);
            unit.nozzle_state:=pump.nozzle'Val(0);
         when pump.F95 =>
            print("add pump: 95");
            pump.set_price(pump_num, 2.10);
            pump.set_state(pump_num, pump.state'Val(0));
            pump.set_nozzle_state(pump_num,pump.nozzle'Val(0));
            pump.set_reservoir(pump_num, fueltype);
            pump.set_reservoir_size(pump_num, 1000.00);
            unit.pump_95:= pump_num;
            unit.is_occupied := False;
            unit.is_paid:= True;
            unit.pay :=0.00;
            unit.fuel_amount:= 0.00;
            unit.current_state := pump.state'Val(0);
            unit.nozzle_state:=pump.nozzle'Val(0);
         when pump.Diesel =>
            print("add pump: Diesel");
            pump.set_price(pump_num, 1.10);
            pump.set_state(pump_num, pump.state'Val(0));
            pump.set_nozzle_state(pump_num,pump.nozzle'Val(0));
            pump.set_reservoir(pump_num, fueltype);
            pump.set_reservoir_size(pump_num, 1000.00);
            unit.pump_Diesel:= pump_num;
            unit.is_occupied := False;
            unit.is_paid:= True;
            unit.pay :=0.00;
            unit.fuel_amount:= 0.00;
            unit.current_state := pump.state'Val(0);
            unit.nozzle_state:=pump.nozzle'Val(0);
      end case;
      print("");
   end add_pump;

   procedure lift_nozzle(unit: in out pump_unit; pump_num : in out pump.pump; fueltype: in pump.fuel_types) is
   begin
      unit.is_occupied:=True;
      if pump.state'Image(unit.current_state) ="BASE" or (pump.state'Image(unit.current_state) ="WAITING" and pump.state'Image(pump.get_state(pump_num))="WAITING") then
         unit.current_state:=pump.state'Val(1);
         unit.avaliable_fuel:=fueltype;
         unit.nozzle_state:=pump.nozzle'Val(1);
         pump.set_state(pump_num, pump.state'Val(1));
         pump.set_nozzle_state(pump_num, pump.nozzle'Val(1));
         print("---The nozzle is ready---.");
      else
         success:=False;
         print("you are only allowed to use one nozzle at the same time.");
      end if;
   end lift_nozzle;

   procedure replace_nozzle (unit: in out pump_unit; pump_num : in out pump.pump) is
   begin
      if pump.state'Image(unit.current_state)="READY" and pump.state'Image(pump.get_state(pump_num))="READY" then
         if unit.pay>0.00 then
            unit.current_state:=pump.state'Val(3);
            unit.nozzle_state:=pump.nozzle'Val(2);
            pump.set_state(pump_num, pump.state'Val(3));
            pump.set_nozzle_state(pump_num, pump.nozzle'Val(2));
            print_float("The nozzle has been returned to the waiting state, your payment is: ",unit.pay);
         else
            unit.is_occupied:=False;
            unit.current_state:=pump.state'Val(0);
            unit.nozzle_state:=pump.nozzle'Val(0);
            pump.set_state(pump_num, pump.state'Val(0));
            pump.set_nozzle_state(pump_num, pump.nozzle'Val(0));
            print("The nozzle has been returned to the waiting state, your payment is 0");
         end if;
      else
         success := False;
         print("You are not allowed to use this nozzle.");
      end if;
   end replace_nozzle;

   procedure start_pumping (unit: in out pump_unit; pump_num : in out pump.pump; amount: in pump.float_number; car_space: in out pump.float_number) is
      tanksize: pump.float_number;  --The currently total fuel amount of this pump
      pumped: pump.float_number:=0.00;  --The pumped fuel amount
      sensor: Boolean:= False;   --indicates whether the car's fuel tank is full
   begin
      if unit.current_state=pump.Ready and pump_num.pump_state=pump.Ready then
         tanksize:= pump.get_total(pump_num);
         if tanksize-1.00<=0.00 then
            print("The tank is empty.");
         end if;
         if car_space<=0.00 then
            sensor:=True;
            print_boolean("Your car has full fuel: ", sensor);
         end if;
         if amount>0.00 and sensor=False and tanksize>0.00 then
            unit.current_state:=pump.state'Val(2);
            unit.nozzle_state:=pump.nozzle'Val(3);
            pump.set_state(pump_num, pump.state'Val(2));
            pump.set_nozzle_state(pump_num, pump.nozzle'Val(3));
            loop
               if car_space-1.00 >= 0.00 and pumped <=amount then
                  pumped:=pumped+1.00;
                  unit.fuel_amount := unit.fuel_amount+1.00;
                  unit.pay:=unit.pay + (1.00* pump.get_price(pump_num));
                  car_space:=car_space-1.00;
                  pump.remove_reservoir(pump_num);
                  tanksize:=pump.get_total(pump_num);
                  if tanksize -1.00 <= 0.00 then
                     print("The tank is empty.");
                     exit when tanksize-1.00<=0.00;
                  elsif pumped>=amount then
                     print("Pumping finished.");
                     exit when pumped>= amount;
                  end if;
               end if;
               if car_space<=0.00 then
                  sensor:=True;
                  print_boolean("Your car has full fuel: ", sensor);
               end if;
               exit when car_space <=0.00;
            end loop;
            success:=True;
            stop_pumping(unit, pump_num);
         end if;
      else
         success :=False;
         print("Please lift the nozzle firstly. Only the pump is ready, pumping can be started");
      end if;
   end start_pumping;

   procedure stop_pumping (unit: in out pump_unit; pump_num : in out pump.pump) is
   begin
      if pump.state'Image(unit.current_state) ="PUMPING" and pump.state'Image(pump.get_state(pump_num))="PUMPING" then
         unit.current_state:=pump.state'Val(1);
         unit.nozzle_state:=pump.nozzle'Val(4);
         pump.set_state(pump_num, pump.state'Val(1));
         pump.set_nozzle_state(pump_num, pump.nozzle'Val(4));
         print("stop pumping");
      else
         success :=False;
         print("stop pumping failed.");
      end if;
   end stop_pumping;

   function get_pump(unit: in pump_unit; fueltype: in pump.fuel_types) return pump.pump is
   begin
      case fueltype is
         when pump.F91=> return unit.pump_91;
         when pump.F95=> return unit.pump_95;
         when pump.Diesel=> return unit.pump_Diesel;
      end case;
   end get_pump;

   function get_total(unit: in pump_unit; fueltype: in pump.fuel_types) return pump.float_number is
   begin
       case fueltype is
         when pump.F91=> return pump.get_total(unit.pump_91);
         when pump.F95=> return pump.get_total(unit.pump_95);
         when pump.Diesel=> return pump.get_total(unit.pump_Diesel);
      end case;
   end get_total;

   function get_id(unit: in pump_unit) return unit_id is
   begin
      return unit.id;
   end get_id;

   function get_pay(unit:in pump_unit) return pump.float_number is
   begin
      return unit.pay;
   end get_pay;

   function get_fuel_amount(unit:in pump_unit) return pump.float_number is
   begin
      return unit.fuel_amount;
   end get_fuel_amount;

   function get_fuel(unit:in pump_unit) return pump.fuel_types is
   begin
      return unit.avaliable_fuel;
   end get_fuel;

   function is_occupied(unit: in pump_unit) return Boolean is
   begin
      return unit.is_occupied;
   end is_occupied;

   function is_paid(unit: in pump_unit) return Boolean is
   begin
      return unit.is_paid;
   end is_paid;

   function get_unit_state(unit: in pump_unit)return pump.state is
   begin
      return unit.current_state;
   end get_unit_state;

   function get_nozzle_state(unit: in pump_unit) return pump.nozzle is
   begin
      return unit.nozzle_state;
   end get_nozzle_state;

end unit;










