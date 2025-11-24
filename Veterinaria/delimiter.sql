delimiter //

create procedure calcular_iva(inout total double)
begin
set total=total*1.19;
end; //
delimiter;

delimiter //
create procedure mostrar_cliente_venta_id(in v_id int, out v_cliente varchar(50))
begin
    select concat(c.nombre, ' ', c.apellido) into v_cliente
    from venta v 
    left join persona c on v.cliente_id = c.id 
    where v.id = v_id;
end; //
delimiter ;

-- CLASE PROCEDIMIENTOS

DELIMITER //
CREATE PROCEDURE mostrardetallecompra()
BEGIN
    SELECT c.id, p.nombre, c.cantidad, c.subtotal, c.compra FROM detalle_compra c LEFT JOIN producto p ON c. producto_id = p.id; //
END; //
DELIMITER ;

SHOW PROCEDURE STATUS WHERE db = "veterinaria"; //

SHOW CREATE PROCEDURE mostrardetallecompra; // 

DROP PROCEDURE mostrardetallecompra; //

-- PARAMETROS: 
-- IN -> VARIABLE DE INGRESO
-- OUT -> VARIABLE DE SALIDA
-- INOUT -> PROCESAR DATOS

DELIMITER //
CREATE PROCEDURE mostrardetallecompra(IN v_id INT)
BEGIN
    SELECT dc.id, p.nombre, dc.cantidad, dc.subtotal, dc.compra FROM detalle_compra dc LEFT JOIN producto p ON dc. producto_id = p.id WHERE dc.id=v_id; //
END; //
DELIMITER ;

CALL mostrardetallecompra_id(2);

DELIMITER //
CREATE PROCEDURE mostrar_cliente_vendedor_venta_id(IN v_id INT, OUT v_cliente VARCHAR(50), OUT v_vendedor VARCHAR(50))
BEGIN
    SELECT CONCAT(c.nombre, ' ', c.apellido) AS nombre_cliente, CONCAT(u.nombre, ' ', u.apellido) AS nombre_vendedor INTO v_cliente, v_vendedor FROM venta v LEFT JOIN persona c ON v.cliente_id = c.id LEFT JOIN persona u ON v.usuario_id = u.id WHERE v.id = v_id;  
END; //
DELIMITER ;

CALL mostrar_cliente_vendedor_venta_id(1, @nombre_cliente, @vendedor);

SELECT 'EL NOMBRE DEL CLIENTE AL QUE SE LE VENDIO ES: ', @nombre_cliente;

DELIMITER //
CREATE PROCEDURE calcular_iva(INOUT total DOUBLE)
BEGIN
    SET total = total * 1.19;
END; //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE calcular_iva_venta_id(IN v_id INT, INOUT v_total DOUBLE)
    SELECT total INTO v_total FROM venta WHERE id = v_id;
    SET v_total = v_total * 1.19;
END; //
DELIMITER ;

CALL calcular_iva_venta_id(1, @total);

delimiter //
create procedure mostrar_detalle_venta(in v_id int)
begin
declare tipo_articulo varchar(50);
end; //
delimiter ;
delimiter //
create procedure mostrar_detalleventa(in v_id int)
begin
declare v_tipo_articulo varchar(50);
select tipo_venta into v_tipo_articulo from detalle_venta where id=v_id;

if v_tipo_articulo='producto' then
select dv.id, dv.tipo_venta, p.descripcion, dv.cantidad, dv.subtotal, dv.venta_id from detalle_venta dv left join producto p
on dv.codigo=p.id where dv.id=v_id;

elseif v_tipo_articulo='paquete' then
select dv.id, dv.tipo_venta, p.nombre, dv.cantidad, dv.subtotal, dv.venta_id from detalle_venta dv left join paquete p
on dv.codigo=p.id where dv.id=v_id;

else
select dv.id, dv.tipo_venta, s.nombre, dv.cantidad, dv.subtotal, dv.venta_id from detalle_venta dv left join servicio s
on dv.codigo=s.id where dv.id=v_id;

end if;
end; //
delimiter ;

////////////////////////////////////////
SELECT
    P.nombre AS NombrePersona,
    P.apellido AS ApellidoPersona,
    P.documento AS Documento,
    V.tarjeta_profesional AS TarjetaProfesional,
    CASE WHEN V.id IS NOT NULL THEN 'Sí' ELSE 'No' END AS EsVeterinario
FROM
    persona P
LEFT JOIN
    veterinario V ON P.id = V.id; 
////////////////////////////////////////// 
-- CLASE CONDICIONALES

-- TIPOS: 
-- IF -> SI
-- CONDICION -> 
-- THEN ->
-- CASE ->
-- LOOK ->

DELIMITER // 
CREATE PROCEDURE mostrar_detalle_venta(IN v_id INT)
BEGIN
    DECLARE v_tipo_articulo VARCHAR(50);
    SELECT tipo_venta INTO v_tipo_articulo FROM detalle_venta WHERE id = v_id;  

    IF v_tipo_articulo = 'producto' THEN 
        SELECT dv.id, dv.tipo_venta, p.nombre, p.descripcion, dv.cantidad, dv.subtotal, dv.venta_id FROM detalle_venta dv LEFT JOIN producto p 
        ON dv.codigo = p.id WHERE dv.id = v_id;
    ELSE IF v_tipo_articulo = 'paquete' THEN
        SELECT dv.id, dv.tipo_venta, p.nombre, dv.cantidad, dv.subtotal, dv.venta_id FROM detalle_venta dv LEFT JOIN paquete p 
        ON dv.codigo = p.id WHERE dv.id = v_id;
    ELSE
        SELECT dv.id, dv.tipo_venta, s.nombre, dv.cantidad, dv.subtotal, dv.venta_id FROM detalle_venta dv LEFT JOIN servicio s
        ON dv.codigo = s.id WHERE dv.id = v_id;
    END IF;
END; //
DELIMITER ;

CALL mostrar_detalle_venta(17);

SELECT dv.id, IF(dv.tipo_venta = 'producto', p.nombre, IF(dv.tipo_venta = 'paquete', pa.nombre, IF(dv.tipo_venta = 'servicio', s.nombre, NULL))) AS articulo, dv.cantidad, dv.subtotal FROM detalle_venta dv LEFT JOIN producto p ON dv.codigo = p.id LEFT JOIN paquete pa ON dv.codigo = pa.id LEFT JOIN servicio s ON dv.codigo = s.id WHERE dv.venta_id = 3;

SELECT dv.id, IF(dv.tipo_venta = 'producto', p.nombre, IF(dv.tipo_venta = 'paquete', pa.nombre, IF(dv.tipo_venta = 'servicio', s.nombre, NULL))) AS articulo, dv.cantidad, dv.subtotal FROM detalle_venta dv LEFT JOIN producto p ON dv.codigo = p.id LEFT JOIN paquete pa ON dv.codigo = pa.id LEFT JOIN servicio s ON dv.codigo = s.id;

DELIMITER //
create procedure sumarnumeros(in cantidad int)
begin
declare contador int default 0;
declare suma int default 0;
while contador<cantidad do
set contador=cantidad+1;
set suma=suma+2;
end while;
select concat('la suma es:' suma);
end;//
