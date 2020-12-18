--(IC1) For every transformer, pv must correspond to the voltage of the busbar identified by pbbid.
create or replace function insert_pv()
returns trigger as
    $$
        begin
            if new.pv not in (
                select voltage
                from busbar
                where new.pbbid = id
                )then
                    raise exception 'The transformer primary voltage does not match the busbar voltage.';
            end if;
            return new;
        end
    $$ language plpgsql;

drop trigger if exists insert_pv_trigger on transformer;
create trigger insert_pv_trigger
before insert or update on transformer
for each row execute procedure insert_pv();

--(IC2) For every transformer, sv must correspond to the voltage of the busbar identified by sbbid.
create or replace function insert_sv()
returns trigger as
$$
    begin
         if new.sv not in (
                select voltage
                from busbar
                where new.sbbid = id
                )then
                    raise exception 'The transformer secondary voltage does not match the busbar voltage.';
        end if;
        return new;
    end;
    $$ language plpgsql;

drop trigger if exists insert_sv_trigger on transformer;
create trigger insert_sv_trigger
before insert or update on transformer
for each row execute procedure insert_sv();

--(IC5) For every analysis concerning a transformer, the name, address values cannot coincide with
--sname, saddress values of the substation where the transformer is located (i.e., gpslat and gpslong
--have the same values in transformer and substation).
create or replace function insert_add_name()
returns trigger as
$$
    begin
        if (new.name, new.address) in(
            select sname, saddress
            from substation
            where gpslat in(
                select gpslat
                from transformer
                where new.id = id
                )
            and gpslong in(
                select gpslong
                from transformer
                where new.id = id
                )) then
            raise exception '% already supervises the substation where the transformer to be analysed is located in.', new.name;
        end if;
        return new;
    end;
    $$ language plpgsql;

-- trigger only on analyses? should I have a trigger onsupervisor and
drop trigger if exists insert_add_name_trigger on analyses;
create trigger insert_add_name_trigger
before insert or update on analyses
for each row execute procedure insert_add_name();

--(IC5) For every analysis concerning a transformer, the name, address values cannot coincide with
--sname, saddress values of the substation where the transformer is located (i.e., gpslat and gpslong
--have the same values in transformer and substation).
create or replace function update_substation()
returns trigger as
$$
    begin
        if (new.sname, new.saddress) in(
            select name, address
            from analyses
            where id in(
                select id
                from transformer t
                where new.gpslat = t.gpslat and new.gpslong = t.gpslong
                )) then
            raise exception '% already analyses the transformer located in the substation you are trying to update.', new.sname;
        end if;
        return new;
    end;
$$ language plpgsql;

drop trigger if exists update_substation_trigger on substation;
create trigger update_substation_trigger
before update on substation
for each row execute procedure update_substation();