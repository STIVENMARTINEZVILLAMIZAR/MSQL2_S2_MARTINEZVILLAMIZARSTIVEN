DELIMITER //

CREATE FUNCTION sumar_pares(cantidad INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE contador INT DEFAULT 0;
    DECLARE suma INT DEFAULT 0;

    WHILE contador < cantidad DO
        SET contador = contador + 1;
        SET suma = suma + 2;   -- suma de números pares (2,4,6,...)
    END WHILE;

    RETURN suma;
END //

DELIMITER ;





DELIMITER //

CREATE FUNCTION iva(total DOUBLE)
RETURNS DOUBLE DETERMINISTIC
BEGIN
    DECLARE resultado DOUBLE;
    SET resultado = total * 1.10;
    RETURN resultado;
END //

DELIMITER ;

SHOW FUNCTION STATUS WHERE Db = 'veterinaria';


select iva(40000);

select total, iva(total) as iva_aplicado from venta;


DELIMITER //
    CREATE FUNCTION  descuento_cantidad(id_detalle int)
    returns double
    not deterministic
    reads sql dat
    reads sql data
    begin
    

    declare v_subtotal double;
    declare v_cantidad int;
    select  subtotal, cantidad into v_subtotal, v_cantidad from detalle_venta WHERE id=id_detalle;
    if 
    end; //
    DELIMITER;



DELIMITER //

CREATE FUNCTION descuento_cantidad(id_detalle INT)
RETURNS DOUBLE
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_subtotal DOUBLE;
    DECLARE v_cantidad INT;

    -- Obtener los datos del detalle de venta
    SELECT subtotal, cantidad
    INTO v_subtotal, v_cantidad
    FROM detalle_venta
    WHERE id = id_detalle;

    -- Aplicar descuentos según la cantidad
    IF v_cantidad >= 2 AND v_cantidad < 3 THEN
        RETURN v_subtotal * 0.8;   -- 20% descuento

    ELSEIF v_cantidad >= 3 AND v_cantidad <= 5 THEN
        RETURN v_subtotal * 0.7;   -- 30% descuento

    ELSE
        RETURN v_subtotal;         -- sin descuento
    END IF;

END //

DELIMITER ;



//DELIMITER
CREATE FUNCTION actualizar_dato()

.