--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


--
-- Name: costo_ruta(integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, idayuda integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
resultado int;
num_positivo int;
costo int;
porcentaje numeric;
ayuda int;
ruta_ayuda int;
BEGIN
INSERT INTO costo_ruta (id_costo_ruta, pasajeros, auxiliares, positivos, bloqueos, velocidad, id_ruta, bea_bruto, id_turno, id_tabla_valor, id_ayuda)
VALUES( idcostoruta, pasajero, auxiliare, positivo, bloqueo, velocida, idruta, beabruto, idturno, idtablavalor, idayuda);
  RAISE NOTICE 'ingreso valores con exitos';

ayuda:= ( SELECT precio FROM costo_ruta AS a1 INNER JOIN ayuda_auxiliar b1 ON a1.id_ayuda = b1.id_ayuda WHERE id_costo_ruta = idcostoruta );
ruta_ayuda :=(SELECT nombre_ruta FROM costo_ruta AS a1 INNER JOIN ayuda_auxiliar b1 ON a1.id_ayuda = b1.id_ayuda WHERE id_costo_ruta = idcostoruta);

IF(id_ayuda = 1) THEN
  UPDATE costo_ruta SET bea_bruto=(bea_bruto - ayuda);
  RAISE NOTICE 'ingreso por %', ruta_ayuda;
    ELSIF (id_ayuda = 2) THEN
      UPDATE costo_ruta SET bea_bruto=(bea_bruto - ayuda);
      RAISE NOTICE 'ingreso por %', ruta_ayuda;
END IF;

    porcentaje:=(select valor_ruta FROM costo_ruta AS a1 INNER JOIN tabla_valor b1 ON a1.id_tabla_valor = id_valor WHERE id_costo_ruta =idcostoruta );
    costo:=(SELECT b1.costo FROM costo_ruta AS a1 INNER JOIN tabla_valor b1 ON a1.id_tabla_valor = b1.id_Valor WHERE id_costo_ruta = idcostoruta);
    num_positivo:=(SELECT positivos FROM costo_ruta WHERE id_costo_ruta = idcostoruta);
    resultado:=(num_positivo * porcentaje) * costo;
    RAISE NOTICE 'el resultado es %', resultado;

  IF (num_positivo >=6) THEN

    UPDATE costo_ruta SET costo_positivo = resultado,
    bea_bruto_total = (bea_bruto + resultado)
    WHERE id_costo_ruta= idcostoruta;
    ELSIF (num_positivo <= 5) THEN
    UPDATE costo_ruta SET bea_bruto_total = bea_bruto;
  END IF;

END;
  $$;


ALTER FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, idayuda integer) OWNER TO postgres;

--
-- Name: costo_ruta(integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, beabrutototal integer, idayuda integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
resultado int;
num_positivo int;
costo int;
porcentaje numeric;
ayuda int;
ruta_ayuda varchar(20);
BEGIN
INSERT INTO costo_ruta (id_costo_ruta, pasajeros, auxiliares, positivos, bloqueos, velocidad, id_ruta, bea_bruto, id_turno, id_tabla_valor, id_ayuda)
VALUES( idcostoruta, pasajero, auxiliare, positivo, bloqueo, velocida, idruta, beabruto, idturno, idtablavalor, idayuda);
  RAISE NOTICE 'ingreso valores con exitos';

ayuda:= ( SELECT precio FROM costo_ruta AS a1 INNER JOIN ayuda_auxiliar b1 ON a1.id_ayuda = b1.id_ayuda WHERE id_costo_ruta = idcostoruta );
ruta_ayuda :=(SELECT nombre_ruta FROM costo_ruta AS a1 INNER JOIN ayuda_auxiliar b1 ON a1.id_ayuda = b1.id_ayuda WHERE id_costo_ruta = idcostoruta);

IF(idayuda = 1) THEN
  UPDATE costo_ruta SET bea_neto=(bea_bruto - ayuda);
  RAISE NOTICE 'ingreso por %', ruta_ayuda;
    ELSIF (idayuda = 2) THEN
      UPDATE costo_ruta SET bea_neto=(bea_bruto - ayuda);
      RAISE NOTICE 'ingreso por %', ruta_ayuda;
END IF;

    porcentaje:=(select valor_ruta FROM costo_ruta AS a1 INNER JOIN tabla_valor b1 ON a1.id_tabla_valor = id_valor WHERE id_costo_ruta =idcostoruta );
    costo:=(SELECT b1.costo FROM costo_ruta AS a1 INNER JOIN tabla_valor b1 ON a1.id_tabla_valor = b1.id_Valor WHERE id_costo_ruta = idcostoruta);
    num_positivo:=(SELECT positivos FROM costo_ruta WHERE id_costo_ruta = idcostoruta);
    resultado:=(num_positivo * porcentaje) * costo;
    RAISE NOTICE 'el resultado es %', resultado;

  IF (num_positivo >=6) THEN

    UPDATE costo_ruta SET costo_positivo = resultado,
    bea_bruto_total  = (bea_neto + resultado)
    WHERE id_costo_ruta= idcostoruta;
    ELSIF (num_positivo <= 5) THEN
    UPDATE costo_ruta SET bea_bruto_total =  (bea_neto + resultado);
  END IF;

END;
  $$;


ALTER FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, beabrutototal integer, idayuda integer) OWNER TO postgres;

--
-- Name: update_costo_ruta(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_costo_ruta() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
usuario varchar(20):=user;
fecha date:= CURRENT_DATE;
hora TIME:= CURRENT_TIME;
BEGIN
IF NEW.positivos <> OLD.positivos OR NEW.bea_bruto <> OLD.bea_bruto THEN
INSERT INTO auditoria_costo_ruta(id_costo_ruta, positivo_ante,positivo_nue, bea_bruto_ante, bea_bruto_nue, usuario,fecha,hora)
VALUES(OLD.id_costo_ruta, OLD.positivos, NEW.positivos, OLD.bea_bruto, NEW.bea_bruto, usuario, fecha, hora);
END IF;
RETURN NULL;
END
$$;


ALTER FUNCTION public.update_costo_ruta() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auditoria_costo_ruta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditoria_costo_ruta (
    id_auditoria_costo integer NOT NULL,
    positivo_ante integer DEFAULT 0 NOT NULL,
    positivo_nue integer DEFAULT 0 NOT NULL,
    bea_bruto_ante integer DEFAULT 0 NOT NULL,
    bea_bruto_nue integer DEFAULT 0 NOT NULL,
    usuario character varying(20) NOT NULL,
    fecha date NOT NULL,
    hora time without time zone NOT NULL,
    id_costo_ruta integer
);


ALTER TABLE public.auditoria_costo_ruta OWNER TO postgres;

--
-- Name: auditoria_costo_ruta_id_auditoria_costo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditoria_costo_ruta_id_auditoria_costo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditoria_costo_ruta_id_auditoria_costo_seq OWNER TO postgres;

--
-- Name: auditoria_costo_ruta_id_auditoria_costo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditoria_costo_ruta_id_auditoria_costo_seq OWNED BY public.auditoria_costo_ruta.id_auditoria_costo;


--
-- Name: ayuda_auxiliar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ayuda_auxiliar (
    id_ayuda integer NOT NULL,
    nombre_ruta character varying(50) NOT NULL,
    precio integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.ayuda_auxiliar OWNER TO postgres;

--
-- Name: ayuda_auxiliar_id_ayuda_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ayuda_auxiliar_id_ayuda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ayuda_auxiliar_id_ayuda_seq OWNER TO postgres;

--
-- Name: ayuda_auxiliar_id_ayuda_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ayuda_auxiliar_id_ayuda_seq OWNED BY public.ayuda_auxiliar.id_ayuda;


--
-- Name: carroceria; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.carroceria (
    id_carroceria integer NOT NULL,
    nombre character varying(15) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.carroceria OWNER TO postgres;

--
-- Name: carroceria_id_carroceria_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.carroceria_id_carroceria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.carroceria_id_carroceria_seq OWNER TO postgres;

--
-- Name: carroceria_id_carroceria_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.carroceria_id_carroceria_seq OWNED BY public.carroceria.id_carroceria;


--
-- Name: causa_novedad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.causa_novedad (
    id_causa_novedad integer NOT NULL,
    nombre_causa character varying(50) NOT NULL,
    id_descripcion_evento integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_novedad_causa_novedad integer
);


ALTER TABLE public.causa_novedad OWNER TO postgres;

--
-- Name: causa_novedad_id_causa_novedad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.causa_novedad_id_causa_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.causa_novedad_id_causa_novedad_seq OWNER TO postgres;

--
-- Name: causa_novedad_id_causa_novedad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.causa_novedad_id_causa_novedad_seq OWNED BY public.causa_novedad.id_causa_novedad;


--
-- Name: clase_bus; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clase_bus (
    id_clase_bus integer NOT NULL,
    nombre character varying(15) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.clase_bus OWNER TO postgres;

--
-- Name: clase_bus_id_clase_bus_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.clase_bus_id_clase_bus_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clase_bus_id_clase_bus_seq OWNER TO postgres;

--
-- Name: clase_bus_id_clase_bus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.clase_bus_id_clase_bus_seq OWNED BY public.clase_bus.id_clase_bus;


--
-- Name: costo_ruta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.costo_ruta (
    id_costo_ruta integer NOT NULL,
    pasajeros integer DEFAULT 0 NOT NULL,
    auxiliares integer DEFAULT 0 NOT NULL,
    positivos integer DEFAULT 0 NOT NULL,
    bloqueos integer DEFAULT 0 NOT NULL,
    velocidad integer DEFAULT 0 NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    id_ruta integer NOT NULL,
    bea_bruto integer DEFAULT 0 NOT NULL,
    id_turno integer,
    id_tabla_valor integer,
    costo_positivo integer DEFAULT 0,
    bea_bruto_total integer DEFAULT 0,
    id_ayuda integer NOT NULL,
    bea_neto integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.costo_ruta OWNER TO postgres;

--
-- Name: costo_ruta_id_costo_ruta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.costo_ruta_id_costo_ruta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.costo_ruta_id_costo_ruta_seq OWNER TO postgres;

--
-- Name: costo_ruta_id_costo_ruta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.costo_ruta_id_costo_ruta_seq OWNED BY public.costo_ruta.id_costo_ruta;


--
-- Name: descripcion_evento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.descripcion_evento (
    id_descripcion_evento integer NOT NULL,
    nombre_descripcion character varying(60) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.descripcion_evento OWNER TO postgres;

--
-- Name: descripcion_evento_id_descipcion_evento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.descripcion_evento_id_descipcion_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.descripcion_evento_id_descipcion_evento_seq OWNER TO postgres;

--
-- Name: descripcion_evento_id_descipcion_evento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.descripcion_evento_id_descipcion_evento_seq OWNED BY public.descripcion_evento.id_descripcion_evento;


--
-- Name: descuento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.descuento (
    id_descuento integer NOT NULL,
    parqueo_lavada integer DEFAULT 0 NOT NULL,
    comida integer DEFAULT 0 NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    combustible integer DEFAULT 0 NOT NULL,
    pago_conductor integer DEFAULT 0 NOT NULL,
    id_peaje integer NOT NULL,
    transbordo integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.descuento OWNER TO postgres;

--
-- Name: descuento_id_descuento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.descuento_id_descuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.descuento_id_descuento_seq OWNER TO postgres;

--
-- Name: descuento_id_descuento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.descuento_id_descuento_seq OWNED BY public.descuento.id_descuento;


--
-- Name: despachador; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.despachador (
    id_despachador integer NOT NULL,
    nombre character varying(30) NOT NULL,
    create_at timestamp without time zone,
    update_at timestamp without time zone
);


ALTER TABLE public.despachador OWNER TO postgres;

--
-- Name: despachador_id_despachador_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.despachador_id_despachador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.despachador_id_despachador_seq OWNER TO postgres;

--
-- Name: despachador_id_despachador_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.despachador_id_despachador_seq OWNED BY public.despachador.id_despachador;


--
-- Name: estado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.estado (
    id_estado_modulo integer NOT NULL,
    nombre_estado character varying(20) NOT NULL,
    estado boolean DEFAULT true
);


ALTER TABLE public.estado OWNER TO postgres;

--
-- Name: estado_id_estado_modulo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.estado_id_estado_modulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estado_id_estado_modulo_seq OWNER TO postgres;

--
-- Name: estado_id_estado_modulo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.estado_id_estado_modulo_seq OWNED BY public.estado.id_estado_modulo;


--
-- Name: gasto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gasto (
    id_gastos integer NOT NULL,
    nombre_gasto character varying(25),
    total_gasto integer DEFAULT 0 NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_turno integer
);


ALTER TABLE public.gasto OWNER TO postgres;

--
-- Name: gastos_id_gastos_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gastos_id_gastos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gastos_id_gastos_seq OWNER TO postgres;

--
-- Name: gastos_id_gastos_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gastos_id_gastos_seq OWNED BY public.gasto.id_gastos;


--
-- Name: marca; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca (
    id_marca integer NOT NULL,
    nombre character varying(25) NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.marca OWNER TO postgres;

--
-- Name: marca_id_marca_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.marca_id_marca_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.marca_id_marca_seq OWNER TO postgres;

--
-- Name: marca_id_marca_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.marca_id_marca_seq OWNED BY public.marca.id_marca;


--
-- Name: novedad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.novedad (
    id_novedad integer NOT NULL,
    nombre_descripcion character varying(300),
    hora_novedad time without time zone DEFAULT CURRENT_TIME NOT NULL,
    dia_novedad date DEFAULT CURRENT_DATE NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_novedad_causa_novedad integer
);


ALTER TABLE public.novedad OWNER TO postgres;

--
-- Name: novedad_causa_novedad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.novedad_causa_novedad (
    id_novedad_causa_novedad integer NOT NULL,
    id_novedad integer NOT NULL,
    id_causa_novedad integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.novedad_causa_novedad OWNER TO postgres;

--
-- Name: novedad_causa_novedad_id_novedad_causa_novedad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.novedad_causa_novedad_id_novedad_causa_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.novedad_causa_novedad_id_novedad_causa_novedad_seq OWNER TO postgres;

--
-- Name: novedad_causa_novedad_id_novedad_causa_novedad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.novedad_causa_novedad_id_novedad_causa_novedad_seq OWNED BY public.novedad_causa_novedad.id_novedad_causa_novedad;


--
-- Name: novedad_id_novedad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.novedad_id_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.novedad_id_novedad_seq OWNER TO postgres;

--
-- Name: novedad_id_novedad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.novedad_id_novedad_seq OWNED BY public.novedad.id_novedad;


--
-- Name: peaje; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.peaje (
    id_peaje integer NOT NULL,
    nombre_peaje character varying(30) DEFAULT 'desconocido'::character varying NOT NULL,
    precio_peaje integer DEFAULT 0 NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.peaje OWNER TO postgres;

--
-- Name: peaje_id_peaje_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.peaje_id_peaje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.peaje_id_peaje_seq OWNER TO postgres;

--
-- Name: peaje_id_peaje_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.peaje_id_peaje_seq OWNED BY public.peaje.id_peaje;


--
-- Name: persona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.persona (
    numero_documento integer NOT NULL,
    primer_nombre character varying(10) NOT NULL,
    segundo_nombre character varying(10) DEFAULT '----'::character varying NOT NULL,
    primer_apellido character varying(10) NOT NULL,
    segundo_apellido character varying(10) DEFAULT '----'::character varying NOT NULL,
    direccion character varying(20) DEFAULT 'Desconocida'::character varying NOT NULL,
    telefono character varying(15) DEFAULT 'Desconocido'::character varying NOT NULL,
    celular character varying(15) DEFAULT 'Desconocido'::character varying NOT NULL,
    email character varying(30) DEFAULT 'Desconocido'::character varying NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_sexo integer NOT NULL,
    id_tipo_documento integer NOT NULL,
    foto character varying
);


ALTER TABLE public.persona OWNER TO postgres;

--
-- Name: recaudo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.recaudo (
    id_recaudo integer NOT NULL,
    hora_recaudo time without time zone NOT NULL,
    dia_recaudo date NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    valor_liquidar integer DEFAULT 0,
    id_turno integer NOT NULL
);


ALTER TABLE public.recaudo OWNER TO postgres;

--
-- Name: recaudo_id_recaudo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.recaudo_id_recaudo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.recaudo_id_recaudo_seq OWNER TO postgres;

--
-- Name: recaudo_id_recaudo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.recaudo_id_recaudo_seq OWNED BY public.recaudo.id_recaudo;


--
-- Name: reloj; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reloj (
    id_reloj integer NOT NULL,
    nombre_reloj character varying(15) DEFAULT 'desconocido'::character varying NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.reloj OWNER TO postgres;

--
-- Name: reloj_id_reloj_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reloj_id_reloj_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reloj_id_reloj_seq OWNER TO postgres;

--
-- Name: reloj_id_reloj_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reloj_id_reloj_seq OWNED BY public.reloj.id_reloj;


--
-- Name: rodamiento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rodamiento (
    id_rodamiento integer NOT NULL,
    hora_salida time without time zone NOT NULL,
    hora_llegada time without time zone NOT NULL,
    id_vehiculo integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.rodamiento OWNER TO postgres;

--
-- Name: rodamiento_id_rodamiento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rodamiento_id_rodamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rodamiento_id_rodamiento_seq OWNER TO postgres;

--
-- Name: rodamiento_id_rodamiento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rodamiento_id_rodamiento_seq OWNED BY public.rodamiento.id_rodamiento;


--
-- Name: rol; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre character varying(20) NOT NULL,
    descripcion character varying(250) DEFAULT 'No tiene'::character varying,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.rol OWNER TO postgres;

--
-- Name: rol_id_rol_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.rol_id_rol_seq OWNER TO postgres;

--
-- Name: rol_id_rol_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;


--
-- Name: ruta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ruta (
    id_ruta integer NOT NULL,
    nombre character varying(35) NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ruta OWNER TO postgres;

--
-- Name: ruta_descuento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ruta_descuento (
    id_ruta_descuento integer NOT NULL,
    id_ruta integer NOT NULL,
    id_descuento integer NOT NULL,
    descripcion character varying(150)
);


ALTER TABLE public.ruta_descuento OWNER TO postgres;

--
-- Name: ruta_descuento_id_ruta_descuento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ruta_descuento_id_ruta_descuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_descuento_id_ruta_descuento_seq OWNER TO postgres;

--
-- Name: ruta_descuento_id_ruta_descuento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ruta_descuento_id_ruta_descuento_seq OWNED BY public.ruta_descuento.id_ruta_descuento;


--
-- Name: ruta_id_ruta_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ruta_id_ruta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_id_ruta_seq OWNER TO postgres;

--
-- Name: ruta_id_ruta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ruta_id_ruta_seq OWNED BY public.ruta.id_ruta;


--
-- Name: ruta_reloj; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ruta_reloj (
    id_ruta_reloj integer NOT NULL,
    id_ruta integer NOT NULL,
    id_reloj integer NOT NULL,
    desprendible_pago_caida integer DEFAULT 0 NOT NULL,
    observacion character varying(250)
);


ALTER TABLE public.ruta_reloj OWNER TO postgres;

--
-- Name: ruta_reloj_id_ruta_reloj_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ruta_reloj_id_ruta_reloj_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ruta_reloj_id_ruta_reloj_seq OWNER TO postgres;

--
-- Name: ruta_reloj_id_ruta_reloj_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ruta_reloj_id_ruta_reloj_seq OWNED BY public.ruta_reloj.id_ruta_reloj;


--
-- Name: sexo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sexo (
    id_sexo integer NOT NULL,
    nombre character varying(15) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    condicion boolean DEFAULT true
);


ALTER TABLE public.sexo OWNER TO postgres;

--
-- Name: sexo_id_sexo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sexo_id_sexo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sexo_id_sexo_seq OWNER TO postgres;

--
-- Name: sexo_id_sexo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sexo_id_sexo_seq OWNED BY public.sexo.id_sexo;


--
-- Name: tabla_valor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tabla_valor (
    id_valor integer NOT NULL,
    nombre_ruta character varying(20) NOT NULL,
    valor_ruta numeric NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    costo integer NOT NULL
);


ALTER TABLE public.tabla_valor OWNER TO postgres;

--
-- Name: tabla_valores_id_valores_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tabla_valores_id_valores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tabla_valores_id_valores_seq OWNER TO postgres;

--
-- Name: tabla_valores_id_valores_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tabla_valores_id_valores_seq OWNED BY public.tabla_valor.id_valor;


--
-- Name: tiempo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiempo (
    id_tiempo_marcada integer NOT NULL,
    tiempo_ideal integer DEFAULT 0 NOT NULL,
    tiempo_marcada integer DEFAULT 0 NOT NULL,
    caida integer DEFAULT 0 NOT NULL,
    id_turno integer NOT NULL
);


ALTER TABLE public.tiempo OWNER TO postgres;

--
-- Name: tiempo_id_tiempo_marcada_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tiempo_id_tiempo_marcada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tiempo_id_tiempo_marcada_seq OWNER TO postgres;

--
-- Name: tiempo_id_tiempo_marcada_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tiempo_id_tiempo_marcada_seq OWNED BY public.tiempo.id_tiempo_marcada;


--
-- Name: tipo_causa_novedad; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_causa_novedad (
    id_tipo_causa_novedad integer NOT NULL,
    id_causa_novedad integer NOT NULL,
    id_novedad integer NOT NULL,
    detalle character varying(100) DEFAULT 'DEFAULT'::character varying NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.tipo_causa_novedad OWNER TO postgres;

--
-- Name: tipo_causa_novedad_id_tipo_causa_novedad_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_causa_novedad_id_tipo_causa_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_causa_novedad_id_tipo_causa_novedad_seq OWNER TO postgres;

--
-- Name: tipo_causa_novedad_id_tipo_causa_novedad_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_causa_novedad_id_tipo_causa_novedad_seq OWNED BY public.tipo_causa_novedad.id_tipo_causa_novedad;


--
-- Name: tipo_documento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_documento (
    id_tipo_documento integer NOT NULL,
    nombre_documento character varying(20),
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    condicion boolean DEFAULT true
);


ALTER TABLE public.tipo_documento OWNER TO postgres;

--
-- Name: tipo_documento_id_documento_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_documento_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tipo_documento_id_documento_seq OWNER TO postgres;

--
-- Name: tipo_documento_id_documento_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_documento_id_documento_seq OWNED BY public.tipo_documento.id_tipo_documento;


--
-- Name: turno; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.turno (
    id_turno integer NOT NULL,
    condicion boolean DEFAULT true NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_despachador integer NOT NULL,
    id_rodamiento integer NOT NULL,
    id_ruta integer NOT NULL,
    id_novedad integer,
    pendiente boolean,
    transito boolean,
    cumplido boolean
);


ALTER TABLE public.turno OWNER TO postgres;

--
-- Name: turno_id_turno_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.turno_id_turno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.turno_id_turno_seq OWNER TO postgres;

--
-- Name: turno_id_turno_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.turno_id_turno_seq OWNED BY public.turno.id_turno;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nick_usuario character varying(20) NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_rol integer NOT NULL,
    numero_documento integer NOT NULL,
    password character varying(50) NOT NULL,
    email character varying(60)
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- Name: vehiculo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vehiculo (
    id_vehiculo integer NOT NULL,
    placa character varying(8),
    numero_interno integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_marca integer NOT NULL,
    id_carroceria integer NOT NULL,
    id_clase_bus integer NOT NULL,
    numero_documento integer NOT NULL,
    modelo integer DEFAULT 0,
    capacidad integer DEFAULT 0
);


ALTER TABLE public.vehiculo OWNER TO postgres;

--
-- Name: vehiculo_id_vehiculo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vehiculo_id_vehiculo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vehiculo_id_vehiculo_seq OWNER TO postgres;

--
-- Name: vehiculo_id_vehiculo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vehiculo_id_vehiculo_seq OWNED BY public.vehiculo.id_vehiculo;


--
-- Name: auditoria_costo_ruta id_auditoria_costo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria_costo_ruta ALTER COLUMN id_auditoria_costo SET DEFAULT nextval('public.auditoria_costo_ruta_id_auditoria_costo_seq'::regclass);


--
-- Name: ayuda_auxiliar id_ayuda; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayuda_auxiliar ALTER COLUMN id_ayuda SET DEFAULT nextval('public.ayuda_auxiliar_id_ayuda_seq'::regclass);


--
-- Name: carroceria id_carroceria; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carroceria ALTER COLUMN id_carroceria SET DEFAULT nextval('public.carroceria_id_carroceria_seq'::regclass);


--
-- Name: causa_novedad id_causa_novedad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causa_novedad ALTER COLUMN id_causa_novedad SET DEFAULT nextval('public.causa_novedad_id_causa_novedad_seq'::regclass);


--
-- Name: clase_bus id_clase_bus; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase_bus ALTER COLUMN id_clase_bus SET DEFAULT nextval('public.clase_bus_id_clase_bus_seq'::regclass);


--
-- Name: costo_ruta id_costo_ruta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta ALTER COLUMN id_costo_ruta SET DEFAULT nextval('public.costo_ruta_id_costo_ruta_seq'::regclass);


--
-- Name: descripcion_evento id_descripcion_evento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descripcion_evento ALTER COLUMN id_descripcion_evento SET DEFAULT nextval('public.descripcion_evento_id_descipcion_evento_seq'::regclass);


--
-- Name: descuento id_descuento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuento ALTER COLUMN id_descuento SET DEFAULT nextval('public.descuento_id_descuento_seq'::regclass);


--
-- Name: despachador id_despachador; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachador ALTER COLUMN id_despachador SET DEFAULT nextval('public.despachador_id_despachador_seq'::regclass);


--
-- Name: estado id_estado_modulo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado ALTER COLUMN id_estado_modulo SET DEFAULT nextval('public.estado_id_estado_modulo_seq'::regclass);


--
-- Name: gasto id_gastos; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gasto ALTER COLUMN id_gastos SET DEFAULT nextval('public.gastos_id_gastos_seq'::regclass);


--
-- Name: marca id_marca; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca ALTER COLUMN id_marca SET DEFAULT nextval('public.marca_id_marca_seq'::regclass);


--
-- Name: novedad id_novedad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novedad ALTER COLUMN id_novedad SET DEFAULT nextval('public.novedad_id_novedad_seq'::regclass);


--
-- Name: novedad_causa_novedad id_novedad_causa_novedad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novedad_causa_novedad ALTER COLUMN id_novedad_causa_novedad SET DEFAULT nextval('public.novedad_causa_novedad_id_novedad_causa_novedad_seq'::regclass);


--
-- Name: peaje id_peaje; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peaje ALTER COLUMN id_peaje SET DEFAULT nextval('public.peaje_id_peaje_seq'::regclass);


--
-- Name: recaudo id_recaudo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recaudo ALTER COLUMN id_recaudo SET DEFAULT nextval('public.recaudo_id_recaudo_seq'::regclass);


--
-- Name: reloj id_reloj; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reloj ALTER COLUMN id_reloj SET DEFAULT nextval('public.reloj_id_reloj_seq'::regclass);


--
-- Name: rodamiento id_rodamiento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rodamiento ALTER COLUMN id_rodamiento SET DEFAULT nextval('public.rodamiento_id_rodamiento_seq'::regclass);


--
-- Name: rol id_rol; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);


--
-- Name: ruta id_ruta; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta ALTER COLUMN id_ruta SET DEFAULT nextval('public.ruta_id_ruta_seq'::regclass);


--
-- Name: ruta_descuento id_ruta_descuento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_descuento ALTER COLUMN id_ruta_descuento SET DEFAULT nextval('public.ruta_descuento_id_ruta_descuento_seq'::regclass);


--
-- Name: ruta_reloj id_ruta_reloj; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_reloj ALTER COLUMN id_ruta_reloj SET DEFAULT nextval('public.ruta_reloj_id_ruta_reloj_seq'::regclass);


--
-- Name: sexo id_sexo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexo ALTER COLUMN id_sexo SET DEFAULT nextval('public.sexo_id_sexo_seq'::regclass);


--
-- Name: tabla_valor id_valor; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_valor ALTER COLUMN id_valor SET DEFAULT nextval('public.tabla_valores_id_valores_seq'::regclass);


--
-- Name: tiempo id_tiempo_marcada; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiempo ALTER COLUMN id_tiempo_marcada SET DEFAULT nextval('public.tiempo_id_tiempo_marcada_seq'::regclass);


--
-- Name: tipo_causa_novedad id_tipo_causa_novedad; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_causa_novedad ALTER COLUMN id_tipo_causa_novedad SET DEFAULT nextval('public.tipo_causa_novedad_id_tipo_causa_novedad_seq'::regclass);


--
-- Name: tipo_documento id_tipo_documento; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento ALTER COLUMN id_tipo_documento SET DEFAULT nextval('public.tipo_documento_id_documento_seq'::regclass);


--
-- Name: turno id_turno; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno ALTER COLUMN id_turno SET DEFAULT nextval('public.turno_id_turno_seq'::regclass);


--
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- Name: vehiculo id_vehiculo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo ALTER COLUMN id_vehiculo SET DEFAULT nextval('public.vehiculo_id_vehiculo_seq'::regclass);


--
-- Name: auditoria_costo_ruta auditoria_costo_ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditoria_costo_ruta
    ADD CONSTRAINT auditoria_costo_ruta_pkey PRIMARY KEY (id_auditoria_costo);


--
-- Name: ayuda_auxiliar ayuda_auxiliar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ayuda_auxiliar
    ADD CONSTRAINT ayuda_auxiliar_pkey PRIMARY KEY (id_ayuda);


--
-- Name: carroceria carroceria_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.carroceria
    ADD CONSTRAINT carroceria_pkey PRIMARY KEY (id_carroceria);


--
-- Name: causa_novedad causa_novedad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causa_novedad
    ADD CONSTRAINT causa_novedad_pkey PRIMARY KEY (id_causa_novedad);


--
-- Name: clase_bus clase_bus_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clase_bus
    ADD CONSTRAINT clase_bus_pkey PRIMARY KEY (id_clase_bus);


--
-- Name: costo_ruta costo_ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT costo_ruta_pkey PRIMARY KEY (id_costo_ruta);


--
-- Name: descripcion_evento descripcion_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descripcion_evento
    ADD CONSTRAINT descripcion_evento_pkey PRIMARY KEY (id_descripcion_evento);


--
-- Name: descuento descuento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuento
    ADD CONSTRAINT descuento_pkey PRIMARY KEY (id_descuento);


--
-- Name: despachador despachador_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.despachador
    ADD CONSTRAINT despachador_pkey PRIMARY KEY (id_despachador);


--
-- Name: estado estado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado_modulo);


--
-- Name: gasto gastos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gasto
    ADD CONSTRAINT gastos_pkey PRIMARY KEY (id_gastos);


--
-- Name: marca marca_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (id_marca);


--
-- Name: novedad novedad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.novedad
    ADD CONSTRAINT novedad_pkey PRIMARY KEY (id_novedad);


--
-- Name: peaje peaje_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.peaje
    ADD CONSTRAINT peaje_pkey PRIMARY KEY (id_peaje);


--
-- Name: persona persona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (numero_documento);


--
-- Name: recaudo recaudo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recaudo
    ADD CONSTRAINT recaudo_pkey PRIMARY KEY (id_recaudo);


--
-- Name: reloj reloj_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reloj
    ADD CONSTRAINT reloj_pkey PRIMARY KEY (id_reloj);


--
-- Name: rodamiento rodamiento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rodamiento
    ADD CONSTRAINT rodamiento_pkey PRIMARY KEY (id_rodamiento);


--
-- Name: rol rol_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);


--
-- Name: ruta_descuento ruta_descuento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_descuento
    ADD CONSTRAINT ruta_descuento_pkey PRIMARY KEY (id_ruta_descuento);


--
-- Name: ruta ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_pkey PRIMARY KEY (id_ruta);


--
-- Name: ruta_reloj ruta_reloj_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_reloj
    ADD CONSTRAINT ruta_reloj_pkey PRIMARY KEY (id_ruta_reloj);


--
-- Name: sexo sexo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sexo
    ADD CONSTRAINT sexo_pkey PRIMARY KEY (id_sexo);


--
-- Name: tabla_valor tabla_valores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tabla_valor
    ADD CONSTRAINT tabla_valores_pkey PRIMARY KEY (id_valor);


--
-- Name: tiempo tiempo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiempo
    ADD CONSTRAINT tiempo_pkey PRIMARY KEY (id_tiempo_marcada);


--
-- Name: tipo_causa_novedad tipo_causa_novedad_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_causa_novedad
    ADD CONSTRAINT tipo_causa_novedad_pkey PRIMARY KEY (id_tipo_causa_novedad);


--
-- Name: tipo_documento tipo_documento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT tipo_documento_pkey PRIMARY KEY (id_tipo_documento);


--
-- Name: turno turno_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_pkey PRIMARY KEY (id_turno);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- Name: vehiculo vehiculo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT vehiculo_pkey PRIMARY KEY (id_vehiculo);


--
-- Name: costo_ruta update_costo; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_costo AFTER UPDATE ON public.costo_ruta FOR EACH ROW EXECUTE PROCEDURE public.update_costo_ruta();


--
-- Name: costo_ruta fk_ayuda_ruta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_ayuda_ruta FOREIGN KEY (id_ayuda) REFERENCES public.ayuda_auxiliar(id_ayuda);


--
-- Name: vehiculo fk_carroceria; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_carroceria FOREIGN KEY (id_carroceria) REFERENCES public.carroceria(id_carroceria);


--
-- Name: causa_novedad fk_causa_n; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.causa_novedad
    ADD CONSTRAINT fk_causa_n FOREIGN KEY (id_descripcion_evento) REFERENCES public.descripcion_evento(id_descripcion_evento);


--
-- Name: vehiculo fk_clase_bus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_clase_bus FOREIGN KEY (id_clase_bus) REFERENCES public.clase_bus(id_clase_bus);


--
-- Name: costo_ruta fk_costo_ruta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_costo_ruta FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);


--
-- Name: ruta_descuento fk_descuento_ruta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_descuento
    ADD CONSTRAINT fk_descuento_ruta FOREIGN KEY (id_descuento) REFERENCES public.descuento(id_descuento);


--
-- Name: turno fk_despachador; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_despachador FOREIGN KEY (id_despachador) REFERENCES public.despachador(id_despachador);


--
-- Name: vehiculo fk_dueno_bus; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_dueno_bus FOREIGN KEY (numero_documento) REFERENCES public.persona(numero_documento);


--
-- Name: gasto fk_gasto; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gasto
    ADD CONSTRAINT fk_gasto FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);


--
-- Name: costo_ruta fk_id_tabla_valor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_id_tabla_valor FOREIGN KEY (id_tabla_valor) REFERENCES public.tabla_valor(id_valor);


--
-- Name: persona fk_id_tipo_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_id_tipo_documento FOREIGN KEY (id_tipo_documento) REFERENCES public.tipo_documento(id_tipo_documento);


--
-- Name: vehiculo fk_marca; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_marca FOREIGN KEY (id_marca) REFERENCES public.marca(id_marca);


--
-- Name: turno fk_novedad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_novedad FOREIGN KEY (id_novedad) REFERENCES public.novedad(id_novedad);


--
-- Name: tipo_causa_novedad fk_novedad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_causa_novedad
    ADD CONSTRAINT fk_novedad FOREIGN KEY (id_novedad) REFERENCES public.novedad(id_novedad);


--
-- Name: usuario fk_numero_documento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_numero_documento FOREIGN KEY (numero_documento) REFERENCES public.persona(numero_documento);


--
-- Name: descuento fk_peaje; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.descuento
    ADD CONSTRAINT fk_peaje FOREIGN KEY (id_peaje) REFERENCES public.peaje(id_peaje);


--
-- Name: ruta_reloj fk_reloj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_reloj
    ADD CONSTRAINT fk_reloj FOREIGN KEY (id_reloj) REFERENCES public.reloj(id_reloj);


--
-- Name: turno fk_rodamiento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_rodamiento FOREIGN KEY (id_rodamiento) REFERENCES public.rodamiento(id_rodamiento);


--
-- Name: turno fk_ruta; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_ruta FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);


--
-- Name: ruta_descuento fk_ruta_descuento; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_descuento
    ADD CONSTRAINT fk_ruta_descuento FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);


--
-- Name: ruta_reloj fk_ruta_reloj; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ruta_reloj
    ADD CONSTRAINT fk_ruta_reloj FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);


--
-- Name: persona fk_sexo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_sexo FOREIGN KEY (id_sexo) REFERENCES public.sexo(id_sexo);


--
-- Name: costo_ruta fk_tabla_valor; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_tabla_valor FOREIGN KEY (id_tabla_valor) REFERENCES public.tabla_valor(id_valor);


--
-- Name: tipo_causa_novedad fk_tipo_causa_novedad; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_causa_novedad
    ADD CONSTRAINT fk_tipo_causa_novedad FOREIGN KEY (id_causa_novedad) REFERENCES public.causa_novedad(id_causa_novedad);


--
-- Name: recaudo fk_turno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.recaudo
    ADD CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);


--
-- Name: tiempo fk_turno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiempo
    ADD CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);


--
-- Name: rodamiento fk_vehiculo; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rodamiento
    ADD CONSTRAINT fk_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES public.vehiculo(id_vehiculo);


--
-- Name: costo_ruta fr_costo_turno; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fr_costo_turno FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);


--
-- PostgreSQL database dump complete
--

