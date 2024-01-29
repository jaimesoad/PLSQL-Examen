create user semp2 identified by 12345;
grant resource to semp2;
grant connect to semp2;
alter session set current_schema = semp2;

CREATE TABLE Empleados
(
    emp_idempleado     NUMBER PRIMARY KEY,
    emp_nombre         VARCHAR2(25)  NOT NULL,
    emp_apellido       VARCHAR2(25)  NOT NULL,
    emp_sexo           CHAR          NOT NULL,
    emp_financiamiento DATE          NOT NULL,
    emp_salarioMensual NUMBER(15, 2) NOT NULL,
    emp_fecha_ingreso  DATE,
    emp_status         CHAR CHECK (emp_status IN ('A', 'I', 'E'))
);

CREATE TABLE Salarioquincenal
(
    sal_idregistro        NUMBER PRIMARY KEY,
    sal_idempleado        NUMBER NOT NULL,
    sal_salquincenalbruto NUMBER(15, 2),
    sal_SeguroSocial      NUMBER(15, 2),
    sal_SeguroEducativo   NUMBER(15, 2),
    sal_netoquincenal     NUMBER(15, 2),
    sal_fecha             DATE,
    CONSTRAINT fk_sal_idempleado FOREIGN KEY (sal_idempleado) REFERENCES Empleados (emp_idempleado)
);

CREATE TABLE AUDITORIA
(
    aud_idtransaccion     NUMBER PRIMARY KEY,
    aud_tabla_afectada    varchar2(20),
    aud_tipo_operacion    char,
    aud_idempleado        number,
    aud_salbrutoquincenal number(15, 2),
    aud_netoquincenal     number(15, 2),
    aud_usuario           varchar2(20),
    aud_fecha             date
);

create or replace function SeguroSocial(
    p_brutoquincenal IN Number(15, 2)
) return number(15, 2) as
begin
    return p_brutoquincenal * 0.0975;
end SeguroSocial;

create or replace function SeguroEducativo(
    p_brutoquincenal IN Number(15, 2)
) return number(15, 2) as
begin
    return p_brutoquincenal * 0.0125;
end SeguroEducativo;

create or replace procedure CalcularSalario(
    p_fecha in Date
) as
    v_social     Number(15, 2);
    v_educativo  number(15, 2);
    v_quincenal  number(15, 2);
    v_bruto      number(15, 2);
    v_mensual    number(15, 2);
    v_idempleado number(15, 2);
    cursor c_salarios is
        select emp_salarioMensual, emp_idempleado
        from Empleados
        where emp_status = 'A';
begin
    open c_salarios;
    loop
        fetch c_salarios into v_mensual, v_idempleado;
        exit when c_salarios%notfound;

        v_bruto := v_mensual / 2;

        v_social := SeguroSocial(v_bruto);
        v_educativo := SeguroEducativo(v_bruto);

        v_quincenal := v_bruto - v_social - v_educativo;

        update Salarioquincenal
        set sal_salquincenalbruto = v_bruto,
            sal_SeguroSocial      = v_social,
            sal_SeguroEducativo   = v_educativo,
            sal_netoquincenal     = v_quincenal,
            sal_fecha = p_fecha
        where sal_idempleado = v_idempleado;
    end loop;
    close c_salarios;
    COMMIT;

end CalcularSalario;

declare
    v_fecha Date;
begin
    v_fecha := sysdate;
    CalcularSalario(v_fecha);
end;

create sequence s_aud;

create or replace trigger trg_aud_salario
    after insert or update or delete
    on Salarioquincenal
    for each row
declare
    v_operacion char;
    v_bruto     number;
    v_neto      number;
    v_empleado  number;
begin
    if inserting then
        v_operacion := 'I';
        v_neto := :new.sal_netoquincenal;
        v_empleado := :new.sal_idempleado;
        v_bruto := :new.sal_salquincenalbruto;

    elsif updating then
        v_operacion := 'U';
        v_neto := :new.sal_netoquincenal;
        v_empleado := :new.sal_idempleado;
        v_bruto := :new.sal_salquincenalbruto;

    elsif deleting then
        v_operacion := 'D';
        v_neto := :old.sal_netoquincenal;
        v_empleado := :old.sal_idempleado;
        v_bruto := :old.sal_salquincenalbruto;
    end if;

    insert into AUDITORIA
    values (s_aud.nextval, 'Salarioquincenal', v_operacion, v_empleado, v_bruto, v_neto, user, sysdate);
end;