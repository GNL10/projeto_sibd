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


create trigger insert_pv_trigger
before insert on transformer --before update or insert?
for each row execute procedure insert_pv(); --for each statement?

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

create trigger insert_sv_trigger
before insert on transformer --before update or insert?
for each row execute procedure insert_sv(); --for each statement?

--(IC5) For every analysis concerning a transformer, the name, address values cannot coincide with
--sname, saddress values of the substation where the transformer is located (i.e., gpslat and gpslong
--have the same values in transformer and substation).
create or replace function insert_add_name()
returns trigger as
$$
    begin
        if exists(select sname, saddress
        from substation
        where gpslat in(
            select gpslat
            from transformer
            where new.id = id
            ) and
              gpslong in(
                select gpslong
                from transformer
                where new.id = id
                )) then
            raise exception '% already supervises the substation where the transformer to be analysed is located in.', new.name;
        end if;
        return new;
    end;
    $$ language plpgsql;

--trigger only on analyses? should I have a trigger onsupervisor and
drop trigger insert_add_name_trigger on analyses;
create trigger insert_add_name_trigger
before insert on analyses --before update or insert?
for each row execute procedure insert_add_name(); --for each statement?
