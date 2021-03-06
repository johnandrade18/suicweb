PGDMP     $    )                w         
   apprecaudo    11.1    11.1 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    28620 
   apprecaudo    DATABASE     �   CREATE DATABASE apprecaudo WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Colombia.1252' LC_CTYPE = 'Spanish_Colombia.1252';
    DROP DATABASE apprecaudo;
             postgres    false                        3079    28653 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                  false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                       false    1                       1255    28662 m   costo_ruta(integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer)    FUNCTION     �  CREATE FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, idayuda integer) RETURNS void
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
 �   DROP FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, idayuda integer);
       public       postgres    false                       1255    28663 v   costo_ruta(integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer, integer)    FUNCTION       CREATE FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, beabrutototal integer, idayuda integer) RETURNS void
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
   DROP FUNCTION public.costo_ruta(idcostoruta integer, pasajero integer, auxiliare integer, positivo integer, bloqueo integer, velocida integer, idruta integer, beabruto integer, idturno integer, idtablavalor integer, beabrutototal integer, idayuda integer);
       public       postgres    false                       1255    28664    update_costo_ruta()    FUNCTION     
  CREATE FUNCTION public.update_costo_ruta() RETURNS trigger
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
 *   DROP FUNCTION public.update_costo_ruta();
       public       postgres    false            �            1259    28665    auditoria_costo_ruta    TABLE     �  CREATE TABLE public.auditoria_costo_ruta (
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
 (   DROP TABLE public.auditoria_costo_ruta;
       public         postgres    false            �            1259    28672 +   auditoria_costo_ruta_id_auditoria_costo_seq    SEQUENCE     �   CREATE SEQUENCE public.auditoria_costo_ruta_id_auditoria_costo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.auditoria_costo_ruta_id_auditoria_costo_seq;
       public       postgres    false    197            �           0    0 +   auditoria_costo_ruta_id_auditoria_costo_seq    SEQUENCE OWNED BY     {   ALTER SEQUENCE public.auditoria_costo_ruta_id_auditoria_costo_seq OWNED BY public.auditoria_costo_ruta.id_auditoria_costo;
            public       postgres    false    198            �            1259    28674    ayuda_auxiliar    TABLE     /  CREATE TABLE public.ayuda_auxiliar (
    id_ayuda integer NOT NULL,
    nombre_ruta character varying(50) NOT NULL,
    precio integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 "   DROP TABLE public.ayuda_auxiliar;
       public         postgres    false            �            1259    28679    ayuda_auxiliar_id_ayuda_seq    SEQUENCE     �   CREATE SEQUENCE public.ayuda_auxiliar_id_ayuda_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.ayuda_auxiliar_id_ayuda_seq;
       public       postgres    false    199            �           0    0    ayuda_auxiliar_id_ayuda_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.ayuda_auxiliar_id_ayuda_seq OWNED BY public.ayuda_auxiliar.id_ayuda;
            public       postgres    false    200            �            1259    28681 
   carroceria    TABLE     �   CREATE TABLE public.carroceria (
    id_carroceria integer NOT NULL,
    nombre character varying(15) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.carroceria;
       public         postgres    false            �            1259    28686    carroceria_id_carroceria_seq    SEQUENCE     �   CREATE SEQUENCE public.carroceria_id_carroceria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.carroceria_id_carroceria_seq;
       public       postgres    false    201            �           0    0    carroceria_id_carroceria_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.carroceria_id_carroceria_seq OWNED BY public.carroceria.id_carroceria;
            public       postgres    false    202            �            1259    28688    causa_novedad    TABLE     Z  CREATE TABLE public.causa_novedad (
    id_causa_novedad integer NOT NULL,
    nombre_causa character varying(50) NOT NULL,
    id_descripcion_evento integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_novedad_causa_novedad integer
);
 !   DROP TABLE public.causa_novedad;
       public         postgres    false            �            1259    28693 "   causa_novedad_id_causa_novedad_seq    SEQUENCE     �   CREATE SEQUENCE public.causa_novedad_id_causa_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 9   DROP SEQUENCE public.causa_novedad_id_causa_novedad_seq;
       public       postgres    false    203            �           0    0 "   causa_novedad_id_causa_novedad_seq    SEQUENCE OWNED BY     i   ALTER SEQUENCE public.causa_novedad_id_causa_novedad_seq OWNED BY public.causa_novedad.id_causa_novedad;
            public       postgres    false    204            �            1259    28695 	   clase_bus    TABLE     �   CREATE TABLE public.clase_bus (
    id_clase_bus integer NOT NULL,
    nombre character varying(15) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.clase_bus;
       public         postgres    false            �            1259    28700    clase_bus_id_clase_bus_seq    SEQUENCE     �   CREATE SEQUENCE public.clase_bus_id_clase_bus_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.clase_bus_id_clase_bus_seq;
       public       postgres    false    205            �           0    0    clase_bus_id_clase_bus_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.clase_bus_id_clase_bus_seq OWNED BY public.clase_bus.id_clase_bus;
            public       postgres    false    206            �            1259    28702 
   costo_ruta    TABLE     �  CREATE TABLE public.costo_ruta (
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
    DROP TABLE public.costo_ruta;
       public         postgres    false            �            1259    28716    costo_ruta_id_costo_ruta_seq    SEQUENCE     �   CREATE SEQUENCE public.costo_ruta_id_costo_ruta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.costo_ruta_id_costo_ruta_seq;
       public       postgres    false    207            �           0    0    costo_ruta_id_costo_ruta_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.costo_ruta_id_costo_ruta_seq OWNED BY public.costo_ruta.id_costo_ruta;
            public       postgres    false    208            �            1259    28718    descripcion_evento    TABLE       CREATE TABLE public.descripcion_evento (
    id_descripcion_evento integer NOT NULL,
    nombre_descripcion character varying(60) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 &   DROP TABLE public.descripcion_evento;
       public         postgres    false            �            1259    28723 +   descripcion_evento_id_descipcion_evento_seq    SEQUENCE     �   CREATE SEQUENCE public.descripcion_evento_id_descipcion_evento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 B   DROP SEQUENCE public.descripcion_evento_id_descipcion_evento_seq;
       public       postgres    false    209            �           0    0 +   descripcion_evento_id_descipcion_evento_seq    SEQUENCE OWNED BY     |   ALTER SEQUENCE public.descripcion_evento_id_descipcion_evento_seq OWNED BY public.descripcion_evento.id_descripcion_evento;
            public       postgres    false    210            �            1259    28725 	   descuento    TABLE     �  CREATE TABLE public.descuento (
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
    DROP TABLE public.descuento;
       public         postgres    false            �            1259    28735    descuento_id_descuento_seq    SEQUENCE     �   CREATE SEQUENCE public.descuento_id_descuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.descuento_id_descuento_seq;
       public       postgres    false    211            �           0    0    descuento_id_descuento_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.descuento_id_descuento_seq OWNED BY public.descuento.id_descuento;
            public       postgres    false    212            �            1259    28737    despachador    TABLE     �   CREATE TABLE public.despachador (
    id_despachador integer NOT NULL,
    nombre character varying(30) NOT NULL,
    create_at timestamp without time zone,
    update_at timestamp without time zone
);
    DROP TABLE public.despachador;
       public         postgres    false            �            1259    28740    despachador_id_despachador_seq    SEQUENCE     �   CREATE SEQUENCE public.despachador_id_despachador_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 5   DROP SEQUENCE public.despachador_id_despachador_seq;
       public       postgres    false    213            �           0    0    despachador_id_despachador_seq    SEQUENCE OWNED BY     a   ALTER SEQUENCE public.despachador_id_despachador_seq OWNED BY public.despachador.id_despachador;
            public       postgres    false    214            �            1259    28742    estado    TABLE     �   CREATE TABLE public.estado (
    id_estado_modulo integer NOT NULL,
    nombre_estado character varying(20) NOT NULL,
    estado boolean DEFAULT true
);
    DROP TABLE public.estado;
       public         postgres    false            �            1259    28746    estado_id_estado_modulo_seq    SEQUENCE     �   CREATE SEQUENCE public.estado_id_estado_modulo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.estado_id_estado_modulo_seq;
       public       postgres    false    215            �           0    0    estado_id_estado_modulo_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.estado_id_estado_modulo_seq OWNED BY public.estado.id_estado_modulo;
            public       postgres    false    216            �            1259    28748    gasto    TABLE     2  CREATE TABLE public.gasto (
    id_gastos integer NOT NULL,
    nombre_gasto character varying(25),
    total_gasto integer DEFAULT 0 NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_turno integer
);
    DROP TABLE public.gasto;
       public         postgres    false            �            1259    28754    gastos_id_gastos_seq    SEQUENCE     �   CREATE SEQUENCE public.gastos_id_gastos_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 +   DROP SEQUENCE public.gastos_id_gastos_seq;
       public       postgres    false    217            �           0    0    gastos_id_gastos_seq    SEQUENCE OWNED BY     L   ALTER SEQUENCE public.gastos_id_gastos_seq OWNED BY public.gasto.id_gastos;
            public       postgres    false    218            �            1259    28756    marca    TABLE       CREATE TABLE public.marca (
    id_marca integer NOT NULL,
    nombre character varying(25) NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.marca;
       public         postgres    false            �            1259    28761    marca_id_marca_seq    SEQUENCE     �   CREATE SEQUENCE public.marca_id_marca_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.marca_id_marca_seq;
       public       postgres    false    219            �           0    0    marca_id_marca_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.marca_id_marca_seq OWNED BY public.marca.id_marca;
            public       postgres    false    220            �            1259    28763    novedad    TABLE     �  CREATE TABLE public.novedad (
    id_novedad integer NOT NULL,
    nombre_descripcion character varying(300),
    hora_novedad time without time zone DEFAULT CURRENT_TIME NOT NULL,
    dia_novedad date DEFAULT CURRENT_DATE NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_novedad_causa_novedad integer
);
    DROP TABLE public.novedad;
       public         postgres    false            �            1259    28770    novedad_causa_novedad    TABLE     A  CREATE TABLE public.novedad_causa_novedad (
    id_novedad_causa_novedad integer NOT NULL,
    id_novedad integer NOT NULL,
    id_causa_novedad integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 )   DROP TABLE public.novedad_causa_novedad;
       public         postgres    false            �            1259    28775 2   novedad_causa_novedad_id_novedad_causa_novedad_seq    SEQUENCE     �   CREATE SEQUENCE public.novedad_causa_novedad_id_novedad_causa_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 I   DROP SEQUENCE public.novedad_causa_novedad_id_novedad_causa_novedad_seq;
       public       postgres    false    222            �           0    0 2   novedad_causa_novedad_id_novedad_causa_novedad_seq    SEQUENCE OWNED BY     �   ALTER SEQUENCE public.novedad_causa_novedad_id_novedad_causa_novedad_seq OWNED BY public.novedad_causa_novedad.id_novedad_causa_novedad;
            public       postgres    false    223            �            1259    28777    novedad_id_novedad_seq    SEQUENCE     �   CREATE SEQUENCE public.novedad_id_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.novedad_id_novedad_seq;
       public       postgres    false    221            �           0    0    novedad_id_novedad_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.novedad_id_novedad_seq OWNED BY public.novedad.id_novedad;
            public       postgres    false    224            �            1259    28779    peaje    TABLE     N  CREATE TABLE public.peaje (
    id_peaje integer NOT NULL,
    nombre_peaje character varying(30) DEFAULT 'desconocido'::character varying NOT NULL,
    precio_peaje integer DEFAULT 0 NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.peaje;
       public         postgres    false            �            1259    28786    peaje_id_peaje_seq    SEQUENCE     �   CREATE SEQUENCE public.peaje_id_peaje_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.peaje_id_peaje_seq;
       public       postgres    false    225            �           0    0    peaje_id_peaje_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.peaje_id_peaje_seq OWNED BY public.peaje.id_peaje;
            public       postgres    false    226            �            1259    28788    persona    TABLE     �  CREATE TABLE public.persona (
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
    DROP TABLE public.persona;
       public         postgres    false            �            1259    28800    recaudo    TABLE     a  CREATE TABLE public.recaudo (
    id_recaudo integer NOT NULL,
    hora_recaudo time without time zone NOT NULL,
    dia_recaudo date NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    valor_liquidar integer DEFAULT 0,
    id_turno integer NOT NULL
);
    DROP TABLE public.recaudo;
       public         postgres    false            �            1259    28806    recaudo_id_recaudo_seq    SEQUENCE     �   CREATE SEQUENCE public.recaudo_id_recaudo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.recaudo_id_recaudo_seq;
       public       postgres    false    228            �           0    0    recaudo_id_recaudo_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.recaudo_id_recaudo_seq OWNED BY public.recaudo.id_recaudo;
            public       postgres    false    229            �            1259    28808    reloj    TABLE     E  CREATE TABLE public.reloj (
    id_reloj integer NOT NULL,
    nombre_reloj character varying(15) DEFAULT 'desconocido'::character varying NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.reloj;
       public         postgres    false            �            1259    28814    reloj_id_reloj_seq    SEQUENCE     �   CREATE SEQUENCE public.reloj_id_reloj_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.reloj_id_reloj_seq;
       public       postgres    false    230            �           0    0    reloj_id_reloj_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.reloj_id_reloj_seq OWNED BY public.reloj.id_reloj;
            public       postgres    false    231            �            1259    28816 
   rodamiento    TABLE     h  CREATE TABLE public.rodamiento (
    id_rodamiento integer NOT NULL,
    hora_salida time without time zone NOT NULL,
    hora_llegada time without time zone NOT NULL,
    id_vehiculo integer NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.rodamiento;
       public         postgres    false            �            1259    28821    rodamiento_id_rodamiento_seq    SEQUENCE     �   CREATE SEQUENCE public.rodamiento_id_rodamiento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.rodamiento_id_rodamiento_seq;
       public       postgres    false    232            �           0    0    rodamiento_id_rodamiento_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.rodamiento_id_rodamiento_seq OWNED BY public.rodamiento.id_rodamiento;
            public       postgres    false    233            �            1259    28823    rol    TABLE     `  CREATE TABLE public.rol (
    id_rol integer NOT NULL,
    nombre character varying(20) NOT NULL,
    descripcion character varying(250) DEFAULT 'No tiene'::character varying,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.rol;
       public         postgres    false            �            1259    28829    rol_id_rol_seq    SEQUENCE     �   CREATE SEQUENCE public.rol_id_rol_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.rol_id_rol_seq;
       public       postgres    false    234            �           0    0    rol_id_rol_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.rol_id_rol_seq OWNED BY public.rol.id_rol;
            public       postgres    false    235            �            1259    28831    ruta    TABLE       CREATE TABLE public.ruta (
    id_ruta integer NOT NULL,
    nombre character varying(35) NOT NULL,
    condicion boolean DEFAULT true,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
    DROP TABLE public.ruta;
       public         postgres    false            �            1259    28837    ruta_descuento    TABLE     �   CREATE TABLE public.ruta_descuento (
    id_ruta_descuento integer NOT NULL,
    id_ruta integer NOT NULL,
    id_descuento integer NOT NULL,
    descripcion character varying(150)
);
 "   DROP TABLE public.ruta_descuento;
       public         postgres    false            �            1259    28840 $   ruta_descuento_id_ruta_descuento_seq    SEQUENCE     �   CREATE SEQUENCE public.ruta_descuento_id_ruta_descuento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ;   DROP SEQUENCE public.ruta_descuento_id_ruta_descuento_seq;
       public       postgres    false    237            �           0    0 $   ruta_descuento_id_ruta_descuento_seq    SEQUENCE OWNED BY     m   ALTER SEQUENCE public.ruta_descuento_id_ruta_descuento_seq OWNED BY public.ruta_descuento.id_ruta_descuento;
            public       postgres    false    238            �            1259    28842    ruta_id_ruta_seq    SEQUENCE     �   CREATE SEQUENCE public.ruta_id_ruta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.ruta_id_ruta_seq;
       public       postgres    false    236            �           0    0    ruta_id_ruta_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.ruta_id_ruta_seq OWNED BY public.ruta.id_ruta;
            public       postgres    false    239            �            1259    28844 
   ruta_reloj    TABLE     �   CREATE TABLE public.ruta_reloj (
    id_ruta_reloj integer NOT NULL,
    id_ruta integer NOT NULL,
    id_reloj integer NOT NULL,
    desprendible_pago_caida integer DEFAULT 0 NOT NULL,
    observacion character varying(250)
);
    DROP TABLE public.ruta_reloj;
       public         postgres    false            �            1259    28848    ruta_reloj_id_ruta_reloj_seq    SEQUENCE     �   CREATE SEQUENCE public.ruta_reloj_id_ruta_reloj_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.ruta_reloj_id_ruta_reloj_seq;
       public       postgres    false    240            �           0    0    ruta_reloj_id_ruta_reloj_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.ruta_reloj_id_ruta_reloj_seq OWNED BY public.ruta_reloj.id_ruta_reloj;
            public       postgres    false    241            �            1259    28850    sexo    TABLE       CREATE TABLE public.sexo (
    id_sexo integer NOT NULL,
    nombre character varying(15) NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    condicion boolean DEFAULT true
);
    DROP TABLE public.sexo;
       public         postgres    false            �            1259    28855    sexo_id_sexo_seq    SEQUENCE     �   CREATE SEQUENCE public.sexo_id_sexo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.sexo_id_sexo_seq;
       public       postgres    false    242            �           0    0    sexo_id_sexo_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.sexo_id_sexo_seq OWNED BY public.sexo.id_sexo;
            public       postgres    false    243            �            1259    28857    tabla_valor    TABLE     :  CREATE TABLE public.tabla_valor (
    id_valor integer NOT NULL,
    nombre_ruta character varying(20) NOT NULL,
    valor_ruta numeric NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    costo integer NOT NULL
);
    DROP TABLE public.tabla_valor;
       public         postgres    false            �            1259    28865    tabla_valores_id_valores_seq    SEQUENCE     �   CREATE SEQUENCE public.tabla_valores_id_valores_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tabla_valores_id_valores_seq;
       public       postgres    false    244            �           0    0    tabla_valores_id_valores_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.tabla_valores_id_valores_seq OWNED BY public.tabla_valor.id_valor;
            public       postgres    false    245            �            1259    28867    tiempo    TABLE     �   CREATE TABLE public.tiempo (
    id_tiempo_marcada integer NOT NULL,
    tiempo_ideal integer DEFAULT 0 NOT NULL,
    tiempo_marcada integer DEFAULT 0 NOT NULL,
    caida integer DEFAULT 0 NOT NULL,
    id_turno integer NOT NULL
);
    DROP TABLE public.tiempo;
       public         postgres    false            �            1259    28873    tiempo_id_tiempo_marcada_seq    SEQUENCE     �   CREATE SEQUENCE public.tiempo_id_tiempo_marcada_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.tiempo_id_tiempo_marcada_seq;
       public       postgres    false    246            �           0    0    tiempo_id_tiempo_marcada_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.tiempo_id_tiempo_marcada_seq OWNED BY public.tiempo.id_tiempo_marcada;
            public       postgres    false    247            �            1259    28875    tipo_causa_novedad    TABLE     {  CREATE TABLE public.tipo_causa_novedad (
    id_tipo_causa_novedad integer NOT NULL,
    id_causa_novedad integer NOT NULL,
    id_novedad integer NOT NULL,
    detalle character varying(100) DEFAULT 'DEFAULT'::character varying NOT NULL,
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 &   DROP TABLE public.tipo_causa_novedad;
       public         postgres    false            �            1259    28881 ,   tipo_causa_novedad_id_tipo_causa_novedad_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_causa_novedad_id_tipo_causa_novedad_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 C   DROP SEQUENCE public.tipo_causa_novedad_id_tipo_causa_novedad_seq;
       public       postgres    false    248            �           0    0 ,   tipo_causa_novedad_id_tipo_causa_novedad_seq    SEQUENCE OWNED BY     }   ALTER SEQUENCE public.tipo_causa_novedad_id_tipo_causa_novedad_seq OWNED BY public.tipo_causa_novedad.id_tipo_causa_novedad;
            public       postgres    false    249            �            1259    28883    tipo_documento    TABLE     )  CREATE TABLE public.tipo_documento (
    id_tipo_documento integer NOT NULL,
    nombre_documento character varying(20),
    create_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    update_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    condicion boolean DEFAULT true
);
 "   DROP TABLE public.tipo_documento;
       public         postgres    false            �            1259    28888    tipo_documento_id_documento_seq    SEQUENCE     �   CREATE SEQUENCE public.tipo_documento_id_documento_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 6   DROP SEQUENCE public.tipo_documento_id_documento_seq;
       public       postgres    false    250            �           0    0    tipo_documento_id_documento_seq    SEQUENCE OWNED BY     h   ALTER SEQUENCE public.tipo_documento_id_documento_seq OWNED BY public.tipo_documento.id_tipo_documento;
            public       postgres    false    251            �            1259    28890    turno    TABLE     �  CREATE TABLE public.turno (
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
    DROP TABLE public.turno;
       public         postgres    false            �            1259    28896    turno_id_turno_seq    SEQUENCE     �   CREATE SEQUENCE public.turno_id_turno_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.turno_id_turno_seq;
       public       postgres    false    252            �           0    0    turno_id_turno_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.turno_id_turno_seq OWNED BY public.turno.id_turno;
            public       postgres    false    253            �            1259    28898    usuario    TABLE     �  CREATE TABLE public.usuario (
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
    DROP TABLE public.usuario;
       public         postgres    false            �            1259    28904    usuario_id_usuario_seq    SEQUENCE     �   CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.usuario_id_usuario_seq;
       public       postgres    false    254            �           0    0    usuario_id_usuario_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;
            public       postgres    false    255                        1259    28906    vehiculo    TABLE     �  CREATE TABLE public.vehiculo (
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
    DROP TABLE public.vehiculo;
       public         postgres    false                       1259    28913    vehiculo_id_vehiculo_seq    SEQUENCE     �   CREATE SEQUENCE public.vehiculo_id_vehiculo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.vehiculo_id_vehiculo_seq;
       public       postgres    false    256            �           0    0    vehiculo_id_vehiculo_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.vehiculo_id_vehiculo_seq OWNED BY public.vehiculo.id_vehiculo;
            public       postgres    false    257            9           2604    28915 '   auditoria_costo_ruta id_auditoria_costo    DEFAULT     �   ALTER TABLE ONLY public.auditoria_costo_ruta ALTER COLUMN id_auditoria_costo SET DEFAULT nextval('public.auditoria_costo_ruta_id_auditoria_costo_seq'::regclass);
 V   ALTER TABLE public.auditoria_costo_ruta ALTER COLUMN id_auditoria_costo DROP DEFAULT;
       public       postgres    false    198    197            <           2604    28916    ayuda_auxiliar id_ayuda    DEFAULT     �   ALTER TABLE ONLY public.ayuda_auxiliar ALTER COLUMN id_ayuda SET DEFAULT nextval('public.ayuda_auxiliar_id_ayuda_seq'::regclass);
 F   ALTER TABLE public.ayuda_auxiliar ALTER COLUMN id_ayuda DROP DEFAULT;
       public       postgres    false    200    199            ?           2604    28917    carroceria id_carroceria    DEFAULT     �   ALTER TABLE ONLY public.carroceria ALTER COLUMN id_carroceria SET DEFAULT nextval('public.carroceria_id_carroceria_seq'::regclass);
 G   ALTER TABLE public.carroceria ALTER COLUMN id_carroceria DROP DEFAULT;
       public       postgres    false    202    201            B           2604    28918    causa_novedad id_causa_novedad    DEFAULT     �   ALTER TABLE ONLY public.causa_novedad ALTER COLUMN id_causa_novedad SET DEFAULT nextval('public.causa_novedad_id_causa_novedad_seq'::regclass);
 M   ALTER TABLE public.causa_novedad ALTER COLUMN id_causa_novedad DROP DEFAULT;
       public       postgres    false    204    203            E           2604    28919    clase_bus id_clase_bus    DEFAULT     �   ALTER TABLE ONLY public.clase_bus ALTER COLUMN id_clase_bus SET DEFAULT nextval('public.clase_bus_id_clase_bus_seq'::regclass);
 E   ALTER TABLE public.clase_bus ALTER COLUMN id_clase_bus DROP DEFAULT;
       public       postgres    false    206    205            Q           2604    28920    costo_ruta id_costo_ruta    DEFAULT     �   ALTER TABLE ONLY public.costo_ruta ALTER COLUMN id_costo_ruta SET DEFAULT nextval('public.costo_ruta_id_costo_ruta_seq'::regclass);
 G   ALTER TABLE public.costo_ruta ALTER COLUMN id_costo_ruta DROP DEFAULT;
       public       postgres    false    208    207            T           2604    28921 (   descripcion_evento id_descripcion_evento    DEFAULT     �   ALTER TABLE ONLY public.descripcion_evento ALTER COLUMN id_descripcion_evento SET DEFAULT nextval('public.descripcion_evento_id_descipcion_evento_seq'::regclass);
 W   ALTER TABLE public.descripcion_evento ALTER COLUMN id_descripcion_evento DROP DEFAULT;
       public       postgres    false    210    209            \           2604    28922    descuento id_descuento    DEFAULT     �   ALTER TABLE ONLY public.descuento ALTER COLUMN id_descuento SET DEFAULT nextval('public.descuento_id_descuento_seq'::regclass);
 E   ALTER TABLE public.descuento ALTER COLUMN id_descuento DROP DEFAULT;
       public       postgres    false    212    211            ]           2604    28923    despachador id_despachador    DEFAULT     �   ALTER TABLE ONLY public.despachador ALTER COLUMN id_despachador SET DEFAULT nextval('public.despachador_id_despachador_seq'::regclass);
 I   ALTER TABLE public.despachador ALTER COLUMN id_despachador DROP DEFAULT;
       public       postgres    false    214    213            _           2604    28924    estado id_estado_modulo    DEFAULT     �   ALTER TABLE ONLY public.estado ALTER COLUMN id_estado_modulo SET DEFAULT nextval('public.estado_id_estado_modulo_seq'::regclass);
 F   ALTER TABLE public.estado ALTER COLUMN id_estado_modulo DROP DEFAULT;
       public       postgres    false    216    215            c           2604    28925    gasto id_gastos    DEFAULT     s   ALTER TABLE ONLY public.gasto ALTER COLUMN id_gastos SET DEFAULT nextval('public.gastos_id_gastos_seq'::regclass);
 >   ALTER TABLE public.gasto ALTER COLUMN id_gastos DROP DEFAULT;
       public       postgres    false    218    217            d           2604    28926    marca id_marca    DEFAULT     p   ALTER TABLE ONLY public.marca ALTER COLUMN id_marca SET DEFAULT nextval('public.marca_id_marca_seq'::regclass);
 =   ALTER TABLE public.marca ALTER COLUMN id_marca DROP DEFAULT;
       public       postgres    false    220    219            l           2604    28927    novedad id_novedad    DEFAULT     x   ALTER TABLE ONLY public.novedad ALTER COLUMN id_novedad SET DEFAULT nextval('public.novedad_id_novedad_seq'::regclass);
 A   ALTER TABLE public.novedad ALTER COLUMN id_novedad DROP DEFAULT;
       public       postgres    false    224    221            o           2604    28928 .   novedad_causa_novedad id_novedad_causa_novedad    DEFAULT     �   ALTER TABLE ONLY public.novedad_causa_novedad ALTER COLUMN id_novedad_causa_novedad SET DEFAULT nextval('public.novedad_causa_novedad_id_novedad_causa_novedad_seq'::regclass);
 ]   ALTER TABLE public.novedad_causa_novedad ALTER COLUMN id_novedad_causa_novedad DROP DEFAULT;
       public       postgres    false    223    222            t           2604    28929    peaje id_peaje    DEFAULT     p   ALTER TABLE ONLY public.peaje ALTER COLUMN id_peaje SET DEFAULT nextval('public.peaje_id_peaje_seq'::regclass);
 =   ALTER TABLE public.peaje ALTER COLUMN id_peaje DROP DEFAULT;
       public       postgres    false    226    225            �           2604    28930    recaudo id_recaudo    DEFAULT     x   ALTER TABLE ONLY public.recaudo ALTER COLUMN id_recaudo SET DEFAULT nextval('public.recaudo_id_recaudo_seq'::regclass);
 A   ALTER TABLE public.recaudo ALTER COLUMN id_recaudo DROP DEFAULT;
       public       postgres    false    229    228            �           2604    28931    reloj id_reloj    DEFAULT     p   ALTER TABLE ONLY public.reloj ALTER COLUMN id_reloj SET DEFAULT nextval('public.reloj_id_reloj_seq'::regclass);
 =   ALTER TABLE public.reloj ALTER COLUMN id_reloj DROP DEFAULT;
       public       postgres    false    231    230            �           2604    28932    rodamiento id_rodamiento    DEFAULT     �   ALTER TABLE ONLY public.rodamiento ALTER COLUMN id_rodamiento SET DEFAULT nextval('public.rodamiento_id_rodamiento_seq'::regclass);
 G   ALTER TABLE public.rodamiento ALTER COLUMN id_rodamiento DROP DEFAULT;
       public       postgres    false    233    232            �           2604    28933 
   rol id_rol    DEFAULT     h   ALTER TABLE ONLY public.rol ALTER COLUMN id_rol SET DEFAULT nextval('public.rol_id_rol_seq'::regclass);
 9   ALTER TABLE public.rol ALTER COLUMN id_rol DROP DEFAULT;
       public       postgres    false    235    234            �           2604    28934    ruta id_ruta    DEFAULT     l   ALTER TABLE ONLY public.ruta ALTER COLUMN id_ruta SET DEFAULT nextval('public.ruta_id_ruta_seq'::regclass);
 ;   ALTER TABLE public.ruta ALTER COLUMN id_ruta DROP DEFAULT;
       public       postgres    false    239    236            �           2604    28935     ruta_descuento id_ruta_descuento    DEFAULT     �   ALTER TABLE ONLY public.ruta_descuento ALTER COLUMN id_ruta_descuento SET DEFAULT nextval('public.ruta_descuento_id_ruta_descuento_seq'::regclass);
 O   ALTER TABLE public.ruta_descuento ALTER COLUMN id_ruta_descuento DROP DEFAULT;
       public       postgres    false    238    237            �           2604    28936    ruta_reloj id_ruta_reloj    DEFAULT     �   ALTER TABLE ONLY public.ruta_reloj ALTER COLUMN id_ruta_reloj SET DEFAULT nextval('public.ruta_reloj_id_ruta_reloj_seq'::regclass);
 G   ALTER TABLE public.ruta_reloj ALTER COLUMN id_ruta_reloj DROP DEFAULT;
       public       postgres    false    241    240            �           2604    28937    sexo id_sexo    DEFAULT     l   ALTER TABLE ONLY public.sexo ALTER COLUMN id_sexo SET DEFAULT nextval('public.sexo_id_sexo_seq'::regclass);
 ;   ALTER TABLE public.sexo ALTER COLUMN id_sexo DROP DEFAULT;
       public       postgres    false    243    242            �           2604    28938    tabla_valor id_valor    DEFAULT     �   ALTER TABLE ONLY public.tabla_valor ALTER COLUMN id_valor SET DEFAULT nextval('public.tabla_valores_id_valores_seq'::regclass);
 C   ALTER TABLE public.tabla_valor ALTER COLUMN id_valor DROP DEFAULT;
       public       postgres    false    245    244            �           2604    28939    tiempo id_tiempo_marcada    DEFAULT     �   ALTER TABLE ONLY public.tiempo ALTER COLUMN id_tiempo_marcada SET DEFAULT nextval('public.tiempo_id_tiempo_marcada_seq'::regclass);
 G   ALTER TABLE public.tiempo ALTER COLUMN id_tiempo_marcada DROP DEFAULT;
       public       postgres    false    247    246            �           2604    28940 (   tipo_causa_novedad id_tipo_causa_novedad    DEFAULT     �   ALTER TABLE ONLY public.tipo_causa_novedad ALTER COLUMN id_tipo_causa_novedad SET DEFAULT nextval('public.tipo_causa_novedad_id_tipo_causa_novedad_seq'::regclass);
 W   ALTER TABLE public.tipo_causa_novedad ALTER COLUMN id_tipo_causa_novedad DROP DEFAULT;
       public       postgres    false    249    248            �           2604    28941     tipo_documento id_tipo_documento    DEFAULT     �   ALTER TABLE ONLY public.tipo_documento ALTER COLUMN id_tipo_documento SET DEFAULT nextval('public.tipo_documento_id_documento_seq'::regclass);
 O   ALTER TABLE public.tipo_documento ALTER COLUMN id_tipo_documento DROP DEFAULT;
       public       postgres    false    251    250            �           2604    28942    turno id_turno    DEFAULT     p   ALTER TABLE ONLY public.turno ALTER COLUMN id_turno SET DEFAULT nextval('public.turno_id_turno_seq'::regclass);
 =   ALTER TABLE public.turno ALTER COLUMN id_turno DROP DEFAULT;
       public       postgres    false    253    252            �           2604    28943    usuario id_usuario    DEFAULT     x   ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);
 A   ALTER TABLE public.usuario ALTER COLUMN id_usuario DROP DEFAULT;
       public       postgres    false    255    254            �           2604    28944    vehiculo id_vehiculo    DEFAULT     |   ALTER TABLE ONLY public.vehiculo ALTER COLUMN id_vehiculo SET DEFAULT nextval('public.vehiculo_id_vehiculo_seq'::regclass);
 C   ALTER TABLE public.vehiculo ALTER COLUMN id_vehiculo DROP DEFAULT;
       public       postgres    false    257    256            �          0    28665    auditoria_costo_ruta 
   TABLE DATA               �   COPY public.auditoria_costo_ruta (id_auditoria_costo, positivo_ante, positivo_nue, bea_bruto_ante, bea_bruto_nue, usuario, fecha, hora, id_costo_ruta) FROM stdin;
    public       postgres    false    197   YQ      �          0    28674    ayuda_auxiliar 
   TABLE DATA               ]   COPY public.ayuda_auxiliar (id_ayuda, nombre_ruta, precio, create_at, update_at) FROM stdin;
    public       postgres    false    199   �Q      �          0    28681 
   carroceria 
   TABLE DATA               Q   COPY public.carroceria (id_carroceria, nombre, create_at, update_at) FROM stdin;
    public       postgres    false    201   ;R      �          0    28688    causa_novedad 
   TABLE DATA               �   COPY public.causa_novedad (id_causa_novedad, nombre_causa, id_descripcion_evento, create_at, update_at, id_novedad_causa_novedad) FROM stdin;
    public       postgres    false    203   �R      �          0    28695 	   clase_bus 
   TABLE DATA               O   COPY public.clase_bus (id_clase_bus, nombre, create_at, update_at) FROM stdin;
    public       postgres    false    205   QU      �          0    28702 
   costo_ruta 
   TABLE DATA               �   COPY public.costo_ruta (id_costo_ruta, pasajeros, auxiliares, positivos, bloqueos, velocidad, create_at, update_at, id_ruta, bea_bruto, id_turno, id_tabla_valor, costo_positivo, bea_bruto_total, id_ayuda, bea_neto) FROM stdin;
    public       postgres    false    207   �U      �          0    28718    descripcion_evento 
   TABLE DATA               m   COPY public.descripcion_evento (id_descripcion_evento, nombre_descripcion, create_at, update_at) FROM stdin;
    public       postgres    false    209   tV      �          0    28725 	   descuento 
   TABLE DATA               �   COPY public.descuento (id_descuento, parqueo_lavada, comida, create_at, update_at, combustible, pago_conductor, id_peaje, transbordo) FROM stdin;
    public       postgres    false    211   xW      �          0    28737    despachador 
   TABLE DATA               S   COPY public.despachador (id_despachador, nombre, create_at, update_at) FROM stdin;
    public       postgres    false    213   �W      �          0    28742    estado 
   TABLE DATA               I   COPY public.estado (id_estado_modulo, nombre_estado, estado) FROM stdin;
    public       postgres    false    215   �W      �          0    28748    gasto 
   TABLE DATA               e   COPY public.gasto (id_gastos, nombre_gasto, total_gasto, create_at, update_at, id_turno) FROM stdin;
    public       postgres    false    217   �W      �          0    28756    marca 
   TABLE DATA               R   COPY public.marca (id_marca, nombre, condicion, create_at, update_at) FROM stdin;
    public       postgres    false    219   �W      �          0    28763    novedad 
   TABLE DATA               �   COPY public.novedad (id_novedad, nombre_descripcion, hora_novedad, dia_novedad, create_at, update_at, id_novedad_causa_novedad) FROM stdin;
    public       postgres    false    221   �X      �          0    28770    novedad_causa_novedad 
   TABLE DATA               }   COPY public.novedad_causa_novedad (id_novedad_causa_novedad, id_novedad, id_causa_novedad, create_at, update_at) FROM stdin;
    public       postgres    false    222   �X      �          0    28779    peaje 
   TABLE DATA               [   COPY public.peaje (id_peaje, nombre_peaje, precio_peaje, create_at, update_at) FROM stdin;
    public       postgres    false    225   �X      �          0    28788    persona 
   TABLE DATA               �   COPY public.persona (numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, direccion, telefono, celular, email, condicion, create_at, update_at, id_sexo, id_tipo_documento, foto) FROM stdin;
    public       postgres    false    227   wY      �          0    28800    recaudo 
   TABLE DATA               x   COPY public.recaudo (id_recaudo, hora_recaudo, dia_recaudo, create_at, update_at, valor_liquidar, id_turno) FROM stdin;
    public       postgres    false    228   �Z      �          0    28808    reloj 
   TABLE DATA               X   COPY public.reloj (id_reloj, nombre_reloj, condicion, create_at, update_at) FROM stdin;
    public       postgres    false    230   �Z      �          0    28816 
   rodamiento 
   TABLE DATA               q   COPY public.rodamiento (id_rodamiento, hora_salida, hora_llegada, id_vehiculo, create_at, update_at) FROM stdin;
    public       postgres    false    232   �Z      �          0    28823    rol 
   TABLE DATA               [   COPY public.rol (id_rol, nombre, descripcion, condicion, create_at, update_at) FROM stdin;
    public       postgres    false    234   �Z      �          0    28831    ruta 
   TABLE DATA               P   COPY public.ruta (id_ruta, nombre, condicion, create_at, update_at) FROM stdin;
    public       postgres    false    236   �[      �          0    28837    ruta_descuento 
   TABLE DATA               _   COPY public.ruta_descuento (id_ruta_descuento, id_ruta, id_descuento, descripcion) FROM stdin;
    public       postgres    false    237   {\      �          0    28844 
   ruta_reloj 
   TABLE DATA               l   COPY public.ruta_reloj (id_ruta_reloj, id_ruta, id_reloj, desprendible_pago_caida, observacion) FROM stdin;
    public       postgres    false    240   �\      �          0    28850    sexo 
   TABLE DATA               P   COPY public.sexo (id_sexo, nombre, create_at, update_at, condicion) FROM stdin;
    public       postgres    false    242   �\      �          0    28857    tabla_valor 
   TABLE DATA               e   COPY public.tabla_valor (id_valor, nombre_ruta, valor_ruta, create_at, update_at, costo) FROM stdin;
    public       postgres    false    244   ,]      �          0    28867    tiempo 
   TABLE DATA               b   COPY public.tiempo (id_tiempo_marcada, tiempo_ideal, tiempo_marcada, caida, id_turno) FROM stdin;
    public       postgres    false    246   �]      �          0    28875    tipo_causa_novedad 
   TABLE DATA               �   COPY public.tipo_causa_novedad (id_tipo_causa_novedad, id_causa_novedad, id_novedad, detalle, create_at, update_at) FROM stdin;
    public       postgres    false    248   �]      �          0    28883    tipo_documento 
   TABLE DATA               n   COPY public.tipo_documento (id_tipo_documento, nombre_documento, create_at, update_at, condicion) FROM stdin;
    public       postgres    false    250   ^      �          0    28890    turno 
   TABLE DATA               �   COPY public.turno (id_turno, condicion, create_at, update_at, id_despachador, id_rodamiento, id_ruta, id_novedad, pendiente, transito, cumplido) FROM stdin;
    public       postgres    false    252   e^      �          0    28898    usuario 
   TABLE DATA               �   COPY public.usuario (id_usuario, nick_usuario, condicion, create_at, update_at, id_rol, numero_documento, password, email) FROM stdin;
    public       postgres    false    254   �^      �          0    28906    vehiculo 
   TABLE DATA               �   COPY public.vehiculo (id_vehiculo, placa, numero_interno, create_at, update_at, id_marca, id_carroceria, id_clase_bus, numero_documento, modelo, capacidad) FROM stdin;
    public       postgres    false    256   �^      �           0    0 +   auditoria_costo_ruta_id_auditoria_costo_seq    SEQUENCE SET     Y   SELECT pg_catalog.setval('public.auditoria_costo_ruta_id_auditoria_costo_seq', 4, true);
            public       postgres    false    198            �           0    0    ayuda_auxiliar_id_ayuda_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.ayuda_auxiliar_id_ayuda_seq', 2, true);
            public       postgres    false    200            �           0    0    carroceria_id_carroceria_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.carroceria_id_carroceria_seq', 3, true);
            public       postgres    false    202            �           0    0 "   causa_novedad_id_causa_novedad_seq    SEQUENCE SET     Q   SELECT pg_catalog.setval('public.causa_novedad_id_causa_novedad_seq', 47, true);
            public       postgres    false    204            �           0    0    clase_bus_id_clase_bus_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.clase_bus_id_clase_bus_seq', 4, true);
            public       postgres    false    206            �           0    0    costo_ruta_id_costo_ruta_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.costo_ruta_id_costo_ruta_seq', 1, false);
            public       postgres    false    208            �           0    0 +   descripcion_evento_id_descipcion_evento_seq    SEQUENCE SET     Z   SELECT pg_catalog.setval('public.descripcion_evento_id_descipcion_evento_seq', 10, true);
            public       postgres    false    210            �           0    0    descuento_id_descuento_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.descuento_id_descuento_seq', 1, false);
            public       postgres    false    212            �           0    0    despachador_id_despachador_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.despachador_id_despachador_seq', 1, false);
            public       postgres    false    214            �           0    0    estado_id_estado_modulo_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('public.estado_id_estado_modulo_seq', 1, false);
            public       postgres    false    216            �           0    0    gastos_id_gastos_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.gastos_id_gastos_seq', 1, false);
            public       postgres    false    218            �           0    0    marca_id_marca_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.marca_id_marca_seq', 13, true);
            public       postgres    false    220            �           0    0 2   novedad_causa_novedad_id_novedad_causa_novedad_seq    SEQUENCE SET     a   SELECT pg_catalog.setval('public.novedad_causa_novedad_id_novedad_causa_novedad_seq', 1, false);
            public       postgres    false    223            �           0    0    novedad_id_novedad_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.novedad_id_novedad_seq', 1, false);
            public       postgres    false    224            �           0    0    peaje_id_peaje_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.peaje_id_peaje_seq', 19, true);
            public       postgres    false    226            �           0    0    recaudo_id_recaudo_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.recaudo_id_recaudo_seq', 1, false);
            public       postgres    false    229            �           0    0    reloj_id_reloj_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.reloj_id_reloj_seq', 1, false);
            public       postgres    false    231            �           0    0    rodamiento_id_rodamiento_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.rodamiento_id_rodamiento_seq', 1, false);
            public       postgres    false    233            �           0    0    rol_id_rol_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.rol_id_rol_seq', 8, true);
            public       postgres    false    235            �           0    0 $   ruta_descuento_id_ruta_descuento_seq    SEQUENCE SET     S   SELECT pg_catalog.setval('public.ruta_descuento_id_ruta_descuento_seq', 1, false);
            public       postgres    false    238            �           0    0    ruta_id_ruta_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.ruta_id_ruta_seq', 12, true);
            public       postgres    false    239            �           0    0    ruta_reloj_id_ruta_reloj_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.ruta_reloj_id_ruta_reloj_seq', 1, false);
            public       postgres    false    241                        0    0    sexo_id_sexo_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.sexo_id_sexo_seq', 5, true);
            public       postgres    false    243                       0    0    tabla_valores_id_valores_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tabla_valores_id_valores_seq', 11, true);
            public       postgres    false    245                       0    0    tiempo_id_tiempo_marcada_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.tiempo_id_tiempo_marcada_seq', 1, false);
            public       postgres    false    247                       0    0 ,   tipo_causa_novedad_id_tipo_causa_novedad_seq    SEQUENCE SET     [   SELECT pg_catalog.setval('public.tipo_causa_novedad_id_tipo_causa_novedad_seq', 1, false);
            public       postgres    false    249                       0    0    tipo_documento_id_documento_seq    SEQUENCE SET     M   SELECT pg_catalog.setval('public.tipo_documento_id_documento_seq', 2, true);
            public       postgres    false    251                       0    0    turno_id_turno_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.turno_id_turno_seq', 1, false);
            public       postgres    false    253                       0    0    usuario_id_usuario_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 1, false);
            public       postgres    false    255                       0    0    vehiculo_id_vehiculo_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('public.vehiculo_id_vehiculo_seq', 4, true);
            public       postgres    false    257            �           2606    28946 .   auditoria_costo_ruta auditoria_costo_ruta_pkey 
   CONSTRAINT     |   ALTER TABLE ONLY public.auditoria_costo_ruta
    ADD CONSTRAINT auditoria_costo_ruta_pkey PRIMARY KEY (id_auditoria_costo);
 X   ALTER TABLE ONLY public.auditoria_costo_ruta DROP CONSTRAINT auditoria_costo_ruta_pkey;
       public         postgres    false    197            �           2606    28948 "   ayuda_auxiliar ayuda_auxiliar_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.ayuda_auxiliar
    ADD CONSTRAINT ayuda_auxiliar_pkey PRIMARY KEY (id_ayuda);
 L   ALTER TABLE ONLY public.ayuda_auxiliar DROP CONSTRAINT ayuda_auxiliar_pkey;
       public         postgres    false    199            �           2606    28950    carroceria carroceria_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.carroceria
    ADD CONSTRAINT carroceria_pkey PRIMARY KEY (id_carroceria);
 D   ALTER TABLE ONLY public.carroceria DROP CONSTRAINT carroceria_pkey;
       public         postgres    false    201            �           2606    28952     causa_novedad causa_novedad_pkey 
   CONSTRAINT     l   ALTER TABLE ONLY public.causa_novedad
    ADD CONSTRAINT causa_novedad_pkey PRIMARY KEY (id_causa_novedad);
 J   ALTER TABLE ONLY public.causa_novedad DROP CONSTRAINT causa_novedad_pkey;
       public         postgres    false    203            �           2606    28954    clase_bus clase_bus_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.clase_bus
    ADD CONSTRAINT clase_bus_pkey PRIMARY KEY (id_clase_bus);
 B   ALTER TABLE ONLY public.clase_bus DROP CONSTRAINT clase_bus_pkey;
       public         postgres    false    205            �           2606    28956    costo_ruta costo_ruta_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT costo_ruta_pkey PRIMARY KEY (id_costo_ruta);
 D   ALTER TABLE ONLY public.costo_ruta DROP CONSTRAINT costo_ruta_pkey;
       public         postgres    false    207            �           2606    28958 *   descripcion_evento descripcion_evento_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.descripcion_evento
    ADD CONSTRAINT descripcion_evento_pkey PRIMARY KEY (id_descripcion_evento);
 T   ALTER TABLE ONLY public.descripcion_evento DROP CONSTRAINT descripcion_evento_pkey;
       public         postgres    false    209            �           2606    28960    descuento descuento_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.descuento
    ADD CONSTRAINT descuento_pkey PRIMARY KEY (id_descuento);
 B   ALTER TABLE ONLY public.descuento DROP CONSTRAINT descuento_pkey;
       public         postgres    false    211            �           2606    28962    despachador despachador_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.despachador
    ADD CONSTRAINT despachador_pkey PRIMARY KEY (id_despachador);
 F   ALTER TABLE ONLY public.despachador DROP CONSTRAINT despachador_pkey;
       public         postgres    false    213            �           2606    28964    estado estado_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public.estado
    ADD CONSTRAINT estado_pkey PRIMARY KEY (id_estado_modulo);
 <   ALTER TABLE ONLY public.estado DROP CONSTRAINT estado_pkey;
       public         postgres    false    215            �           2606    28966    gasto gastos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.gasto
    ADD CONSTRAINT gastos_pkey PRIMARY KEY (id_gastos);
 ;   ALTER TABLE ONLY public.gasto DROP CONSTRAINT gastos_pkey;
       public         postgres    false    217            �           2606    28968    marca marca_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.marca
    ADD CONSTRAINT marca_pkey PRIMARY KEY (id_marca);
 :   ALTER TABLE ONLY public.marca DROP CONSTRAINT marca_pkey;
       public         postgres    false    219            �           2606    28970    novedad novedad_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.novedad
    ADD CONSTRAINT novedad_pkey PRIMARY KEY (id_novedad);
 >   ALTER TABLE ONLY public.novedad DROP CONSTRAINT novedad_pkey;
       public         postgres    false    221            �           2606    28972    peaje peaje_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.peaje
    ADD CONSTRAINT peaje_pkey PRIMARY KEY (id_peaje);
 :   ALTER TABLE ONLY public.peaje DROP CONSTRAINT peaje_pkey;
       public         postgres    false    225            �           2606    28974    persona persona_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT persona_pkey PRIMARY KEY (numero_documento);
 >   ALTER TABLE ONLY public.persona DROP CONSTRAINT persona_pkey;
       public         postgres    false    227            �           2606    28976    recaudo recaudo_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.recaudo
    ADD CONSTRAINT recaudo_pkey PRIMARY KEY (id_recaudo);
 >   ALTER TABLE ONLY public.recaudo DROP CONSTRAINT recaudo_pkey;
       public         postgres    false    228            �           2606    28978    reloj reloj_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.reloj
    ADD CONSTRAINT reloj_pkey PRIMARY KEY (id_reloj);
 :   ALTER TABLE ONLY public.reloj DROP CONSTRAINT reloj_pkey;
       public         postgres    false    230            �           2606    28980    rodamiento rodamiento_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.rodamiento
    ADD CONSTRAINT rodamiento_pkey PRIMARY KEY (id_rodamiento);
 D   ALTER TABLE ONLY public.rodamiento DROP CONSTRAINT rodamiento_pkey;
       public         postgres    false    232            �           2606    28982    rol rol_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.rol
    ADD CONSTRAINT rol_pkey PRIMARY KEY (id_rol);
 6   ALTER TABLE ONLY public.rol DROP CONSTRAINT rol_pkey;
       public         postgres    false    234            �           2606    28984 "   ruta_descuento ruta_descuento_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.ruta_descuento
    ADD CONSTRAINT ruta_descuento_pkey PRIMARY KEY (id_ruta_descuento);
 L   ALTER TABLE ONLY public.ruta_descuento DROP CONSTRAINT ruta_descuento_pkey;
       public         postgres    false    237            �           2606    28986    ruta ruta_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_pkey PRIMARY KEY (id_ruta);
 8   ALTER TABLE ONLY public.ruta DROP CONSTRAINT ruta_pkey;
       public         postgres    false    236            �           2606    28988    ruta_reloj ruta_reloj_pkey 
   CONSTRAINT     c   ALTER TABLE ONLY public.ruta_reloj
    ADD CONSTRAINT ruta_reloj_pkey PRIMARY KEY (id_ruta_reloj);
 D   ALTER TABLE ONLY public.ruta_reloj DROP CONSTRAINT ruta_reloj_pkey;
       public         postgres    false    240            �           2606    28990    sexo sexo_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY public.sexo
    ADD CONSTRAINT sexo_pkey PRIMARY KEY (id_sexo);
 8   ALTER TABLE ONLY public.sexo DROP CONSTRAINT sexo_pkey;
       public         postgres    false    242            �           2606    28992    tabla_valor tabla_valores_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.tabla_valor
    ADD CONSTRAINT tabla_valores_pkey PRIMARY KEY (id_valor);
 H   ALTER TABLE ONLY public.tabla_valor DROP CONSTRAINT tabla_valores_pkey;
       public         postgres    false    244            �           2606    28994    tiempo tiempo_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.tiempo
    ADD CONSTRAINT tiempo_pkey PRIMARY KEY (id_tiempo_marcada);
 <   ALTER TABLE ONLY public.tiempo DROP CONSTRAINT tiempo_pkey;
       public         postgres    false    246            �           2606    28996 *   tipo_causa_novedad tipo_causa_novedad_pkey 
   CONSTRAINT     {   ALTER TABLE ONLY public.tipo_causa_novedad
    ADD CONSTRAINT tipo_causa_novedad_pkey PRIMARY KEY (id_tipo_causa_novedad);
 T   ALTER TABLE ONLY public.tipo_causa_novedad DROP CONSTRAINT tipo_causa_novedad_pkey;
       public         postgres    false    248            �           2606    28998 "   tipo_documento tipo_documento_pkey 
   CONSTRAINT     o   ALTER TABLE ONLY public.tipo_documento
    ADD CONSTRAINT tipo_documento_pkey PRIMARY KEY (id_tipo_documento);
 L   ALTER TABLE ONLY public.tipo_documento DROP CONSTRAINT tipo_documento_pkey;
       public         postgres    false    250            �           2606    29000    turno turno_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.turno
    ADD CONSTRAINT turno_pkey PRIMARY KEY (id_turno);
 :   ALTER TABLE ONLY public.turno DROP CONSTRAINT turno_pkey;
       public         postgres    false    252            �           2606    29002    usuario usuario_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);
 >   ALTER TABLE ONLY public.usuario DROP CONSTRAINT usuario_pkey;
       public         postgres    false    254            �           2606    29004    vehiculo vehiculo_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT vehiculo_pkey PRIMARY KEY (id_vehiculo);
 @   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT vehiculo_pkey;
       public         postgres    false    256                       2620    29005    costo_ruta update_costo    TRIGGER     y   CREATE TRIGGER update_costo AFTER UPDATE ON public.costo_ruta FOR EACH ROW EXECUTE PROCEDURE public.update_costo_ruta();
 0   DROP TRIGGER update_costo ON public.costo_ruta;
       public       postgres    false    207    272            �           2606    29006    costo_ruta fk_ayuda_ruta    FK CONSTRAINT     �   ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_ayuda_ruta FOREIGN KEY (id_ayuda) REFERENCES public.ayuda_auxiliar(id_ayuda);
 B   ALTER TABLE ONLY public.costo_ruta DROP CONSTRAINT fk_ayuda_ruta;
       public       postgres    false    3001    199    207            
           2606    29011    vehiculo fk_carroceria    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_carroceria FOREIGN KEY (id_carroceria) REFERENCES public.carroceria(id_carroceria);
 @   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT fk_carroceria;
       public       postgres    false    256    201    3003            �           2606    29016    causa_novedad fk_causa_n    FK CONSTRAINT     �   ALTER TABLE ONLY public.causa_novedad
    ADD CONSTRAINT fk_causa_n FOREIGN KEY (id_descripcion_evento) REFERENCES public.descripcion_evento(id_descripcion_evento);
 B   ALTER TABLE ONLY public.causa_novedad DROP CONSTRAINT fk_causa_n;
       public       postgres    false    209    203    3011                       2606    29021    vehiculo fk_clase_bus    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_clase_bus FOREIGN KEY (id_clase_bus) REFERENCES public.clase_bus(id_clase_bus);
 ?   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT fk_clase_bus;
       public       postgres    false    3007    205    256            �           2606    29026    costo_ruta fk_costo_ruta    FK CONSTRAINT     {   ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_costo_ruta FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);
 B   ALTER TABLE ONLY public.costo_ruta DROP CONSTRAINT fk_costo_ruta;
       public       postgres    false    3037    236    207            �           2606    29031     ruta_descuento fk_descuento_ruta    FK CONSTRAINT     �   ALTER TABLE ONLY public.ruta_descuento
    ADD CONSTRAINT fk_descuento_ruta FOREIGN KEY (id_descuento) REFERENCES public.descuento(id_descuento);
 J   ALTER TABLE ONLY public.ruta_descuento DROP CONSTRAINT fk_descuento_ruta;
       public       postgres    false    237    3013    211                       2606    29036    turno fk_despachador    FK CONSTRAINT     �   ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_despachador FOREIGN KEY (id_despachador) REFERENCES public.despachador(id_despachador);
 >   ALTER TABLE ONLY public.turno DROP CONSTRAINT fk_despachador;
       public       postgres    false    3015    213    252                       2606    29041    vehiculo fk_dueno_bus    FK CONSTRAINT     �   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_dueno_bus FOREIGN KEY (numero_documento) REFERENCES public.persona(numero_documento);
 ?   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT fk_dueno_bus;
       public       postgres    false    3027    256    227            �           2606    29046    gasto fk_gasto    FK CONSTRAINT     t   ALTER TABLE ONLY public.gasto
    ADD CONSTRAINT fk_gasto FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);
 8   ALTER TABLE ONLY public.gasto DROP CONSTRAINT fk_gasto;
       public       postgres    false    252    217    3053            �           2606    29051    costo_ruta fk_id_tabla_valor    FK CONSTRAINT     �   ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_id_tabla_valor FOREIGN KEY (id_tabla_valor) REFERENCES public.tabla_valor(id_valor);
 F   ALTER TABLE ONLY public.costo_ruta DROP CONSTRAINT fk_id_tabla_valor;
       public       postgres    false    207    244    3045            �           2606    29056    persona fk_id_tipo_documento    FK CONSTRAINT     �   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_id_tipo_documento FOREIGN KEY (id_tipo_documento) REFERENCES public.tipo_documento(id_tipo_documento);
 F   ALTER TABLE ONLY public.persona DROP CONSTRAINT fk_id_tipo_documento;
       public       postgres    false    3051    227    250                       2606    29061    vehiculo fk_marca    FK CONSTRAINT     w   ALTER TABLE ONLY public.vehiculo
    ADD CONSTRAINT fk_marca FOREIGN KEY (id_marca) REFERENCES public.marca(id_marca);
 ;   ALTER TABLE ONLY public.vehiculo DROP CONSTRAINT fk_marca;
       public       postgres    false    219    256    3021                       2606    29066    turno fk_novedad    FK CONSTRAINT     |   ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_novedad FOREIGN KEY (id_novedad) REFERENCES public.novedad(id_novedad);
 :   ALTER TABLE ONLY public.turno DROP CONSTRAINT fk_novedad;
       public       postgres    false    3023    221    252                       2606    29071    tipo_causa_novedad fk_novedad    FK CONSTRAINT     �   ALTER TABLE ONLY public.tipo_causa_novedad
    ADD CONSTRAINT fk_novedad FOREIGN KEY (id_novedad) REFERENCES public.novedad(id_novedad);
 G   ALTER TABLE ONLY public.tipo_causa_novedad DROP CONSTRAINT fk_novedad;
       public       postgres    false    248    3023    221            	           2606    29076    usuario fk_numero_documento    FK CONSTRAINT     �   ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT fk_numero_documento FOREIGN KEY (numero_documento) REFERENCES public.persona(numero_documento);
 E   ALTER TABLE ONLY public.usuario DROP CONSTRAINT fk_numero_documento;
       public       postgres    false    3027    227    254            �           2606    29081    descuento fk_peaje    FK CONSTRAINT     x   ALTER TABLE ONLY public.descuento
    ADD CONSTRAINT fk_peaje FOREIGN KEY (id_peaje) REFERENCES public.peaje(id_peaje);
 <   ALTER TABLE ONLY public.descuento DROP CONSTRAINT fk_peaje;
       public       postgres    false    211    225    3025                        2606    29086    ruta_reloj fk_reloj    FK CONSTRAINT     y   ALTER TABLE ONLY public.ruta_reloj
    ADD CONSTRAINT fk_reloj FOREIGN KEY (id_reloj) REFERENCES public.reloj(id_reloj);
 =   ALTER TABLE ONLY public.ruta_reloj DROP CONSTRAINT fk_reloj;
       public       postgres    false    3031    240    230                       2606    29091    turno fk_rodamiento    FK CONSTRAINT     �   ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_rodamiento FOREIGN KEY (id_rodamiento) REFERENCES public.rodamiento(id_rodamiento);
 =   ALTER TABLE ONLY public.turno DROP CONSTRAINT fk_rodamiento;
       public       postgres    false    232    252    3033                       2606    29096    turno fk_ruta    FK CONSTRAINT     p   ALTER TABLE ONLY public.turno
    ADD CONSTRAINT fk_ruta FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);
 7   ALTER TABLE ONLY public.turno DROP CONSTRAINT fk_ruta;
       public       postgres    false    236    252    3037            �           2606    29101     ruta_descuento fk_ruta_descuento    FK CONSTRAINT     �   ALTER TABLE ONLY public.ruta_descuento
    ADD CONSTRAINT fk_ruta_descuento FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);
 J   ALTER TABLE ONLY public.ruta_descuento DROP CONSTRAINT fk_ruta_descuento;
       public       postgres    false    236    237    3037                       2606    29106    ruta_reloj fk_ruta_reloj    FK CONSTRAINT     {   ALTER TABLE ONLY public.ruta_reloj
    ADD CONSTRAINT fk_ruta_reloj FOREIGN KEY (id_ruta) REFERENCES public.ruta(id_ruta);
 B   ALTER TABLE ONLY public.ruta_reloj DROP CONSTRAINT fk_ruta_reloj;
       public       postgres    false    236    240    3037            �           2606    29111    persona fk_sexo    FK CONSTRAINT     r   ALTER TABLE ONLY public.persona
    ADD CONSTRAINT fk_sexo FOREIGN KEY (id_sexo) REFERENCES public.sexo(id_sexo);
 9   ALTER TABLE ONLY public.persona DROP CONSTRAINT fk_sexo;
       public       postgres    false    242    227    3043            �           2606    29116    costo_ruta fk_tabla_valor    FK CONSTRAINT     �   ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fk_tabla_valor FOREIGN KEY (id_tabla_valor) REFERENCES public.tabla_valor(id_valor);
 C   ALTER TABLE ONLY public.costo_ruta DROP CONSTRAINT fk_tabla_valor;
       public       postgres    false    207    244    3045                       2606    29121 (   tipo_causa_novedad fk_tipo_causa_novedad    FK CONSTRAINT     �   ALTER TABLE ONLY public.tipo_causa_novedad
    ADD CONSTRAINT fk_tipo_causa_novedad FOREIGN KEY (id_causa_novedad) REFERENCES public.causa_novedad(id_causa_novedad);
 R   ALTER TABLE ONLY public.tipo_causa_novedad DROP CONSTRAINT fk_tipo_causa_novedad;
       public       postgres    false    248    203    3005            �           2606    29126    recaudo fk_turno    FK CONSTRAINT     v   ALTER TABLE ONLY public.recaudo
    ADD CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);
 :   ALTER TABLE ONLY public.recaudo DROP CONSTRAINT fk_turno;
       public       postgres    false    3053    228    252                       2606    29131    tiempo fk_turno    FK CONSTRAINT     u   ALTER TABLE ONLY public.tiempo
    ADD CONSTRAINT fk_turno FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);
 9   ALTER TABLE ONLY public.tiempo DROP CONSTRAINT fk_turno;
       public       postgres    false    252    246    3053            �           2606    29136    rodamiento fk_vehiculo    FK CONSTRAINT     �   ALTER TABLE ONLY public.rodamiento
    ADD CONSTRAINT fk_vehiculo FOREIGN KEY (id_vehiculo) REFERENCES public.vehiculo(id_vehiculo);
 @   ALTER TABLE ONLY public.rodamiento DROP CONSTRAINT fk_vehiculo;
       public       postgres    false    3057    232    256            �           2606    29141    costo_ruta fr_costo_turno    FK CONSTRAINT        ALTER TABLE ONLY public.costo_ruta
    ADD CONSTRAINT fr_costo_turno FOREIGN KEY (id_turno) REFERENCES public.turno(id_turno);
 C   ALTER TABLE ONLY public.costo_ruta DROP CONSTRAINT fr_costo_turno;
       public       postgres    false    207    3053    252            �   y   x�u�;�@К��W��p�Q�Dq���.�f
�@N �9���u|���A��I�z0�G��E:i�t~��`%g���<zK���&�� �	�utV�3:��V4��a�T�Y�k)�|�0       �   I   x�3�t�/.IT(�LN�4500�420��54�52S04�2��21�3�073��#�e�霘����X�I�91z\\\ �S      �   K   x�3�tN-*JL��420��54�52T00�25�26�303332�#�e�阔�ZTB�~cN���ĜԢD2����� c�(�      �   �  x����j1���)�1��]��4B詗�vldV�V҆�O�Q�&nY�7��ǚ�����Qye�$��$�(�͈=�Pdy{��E.�զ�7Y�l�fU�y������U��O�K���@�J��Ls����$:(����r�W��KM���1��>�=�m��
e���eլ��=���\)'�����ı�)HW���۸p��NI���>�G	�at��-����;i�V����(��$�أ�MY�e��8)P	����c2U��sh8�IL������9�I�s�H��-�]�װ�:4IH��I�����>m��>�{<-�j6e�l��h���W����͈O�mz�Q�'��ϧ7�����D�..�����1�W���c��u<)������r�b��Ք$/q8��{�f����v�)����zJ�J
�N�����u�sjOSk-�)�GΧI6��SjyZ�O5��&�$����W�H�9e=<��q��2^=�x]�.������8m6Y����]��<�^�6�F8vd>ģ#BS�V������9m�cUƇ��T�~��H�)	)d�"Fؗ�n��9�h�8�r+�C��|�/gcF�a�*�.�cu|��6�|I����뭲�R�6���\��[�u��o��b�@`G�      �   N   x�3�t*-N-I�420��54�52T0��20�25ѳ�02�0�#�e�N�^c��E�~.Ada�雙\��D�b���� ��5w      �   �   x����� D��] �gc��	����i�P>0�I�|H��*	���Q7`��@n�稰�XI �����DH�Y�ߘ3Ȋb��"�T������b�K�6A�zv_I���TB�i"��Ij�ç�����ct[�����x�ƪ��o)_R��tN2v��|�Gi�-i�5-��6��m�1���h�      �   �   x���1n�0Eg��@ɵl�[�l퐡SB&��ʖQ�8=JOV�%��|x �3otᐯ!��+K��B��Fh놃s�Ɓ����?ֶ�]�����3~H��|�2��s<Qܨ�К�k����`���7�e�TH��UҌ�<���)��3'�B+��$k!�W��ԈJ	�9S�i�.y�r��9eJ�a�p�C!�Y�z��3k����n��~t�>�fh��꽮������      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x��ҿ�0���ק� ��?��H���8�4�@cC�_w��/�o.�#���%��D�����V�����������d#N���\��������+t�O6�5nnؼA_#�\����>��'lk��d�����ڙ_��*��!)\w7�oA��+;�,�_�ū�      �      x������ � �      �      x������ � �      �   �   x�3�H���,J�uN���44040�420��54�52T0��24�2��3��037�#�e�b���)�FÍr*MO�ʀl�L8A���cD��L�hqR�73΀�ĔTj��9gr~qI�n2�e��Y�y��8�|���� ���9      �   �   x����j�0��~�K�b9�z�aOЋ���:4m���/Y(�.馋�~�"�ʱ!����<Ч�]�u��͐��k�} ��˯���A)KBeBͮf��J، �r�G��9M�2u� 	A\[��{�}����ӝ�gO��G _�T�d��b�7�;�18����aק���4�.�cl����e��*V�������S������q��c��f8�mq��PIN��i>il،V�AE�	_V�      �      x������ � �      �      x������ � �      �      x������ � �      �   �   x�}�Aj!E�z
/�b�vk��m6�@6z�`����!Lg`Bo�*<�w��w�ȍ{����l��z=��@47�Q�mĠ=9
�I'�+oe�|,*e������N���DQ'HZ��%�监[fu����9Z�a�=�$q�O��V������<_����,�"? Ě.��;��q���WQ�� �yMց�$ߴ��pk�      �   �   x���M
� ൞��$�es�,��ƒP��M�_�4Ph	Ew���{Hk�c����h�H� ����ʔ��B#��d�?;�Kf�l���V���^2T��tɎSmq�KV긎���u�����%;��9N~JW@���V �>���~�6���EV�����X�(ȵ������TPJ_]6��      �      x������ � �      �      x������ � �      �   g   x�3�tK�M�����420��54�52T0��2��25׳40526�'U�e��X�\�C����y)�i�y�)`C,u�*�ͬ�ͭ���,�Ȕp��qqq ��,Z      �   �   x���A� ���p
/ ���Y��j�&�5��EL�7�'��`���s�]��/�m�&�v�[Ӛ��d�Y ���G�r-�#l?e,[����Ī�����t���dK��䉅��)��%,>��XLK�m�
�xi������kK�\�K^	��.J�'�{      �      x������ � �      �      x������ � �      �   >   x�3�t�s�420��54�52T0��2��24ѳ�0003�'U�e�����J�1z\\\ ��3      �      x������ � �      �   ^   x�3�����K�K)JLI�,�420��50�52Q04�2��2��3121�-a�ihhjhibnin����[Ze`dh�l���CF~Inbf�^r~.W� �:      �   }   x�}�11��y�hױ_�B�%�'����ƻ�������`l䦼�[�D�e$e,�R͡�$�x���U�n��pp�cN:� �|^��Wb�n��~���:�?�؅��9��2O4�     