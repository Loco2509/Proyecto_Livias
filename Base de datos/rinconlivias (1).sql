-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-10-2024 a las 23:14:06
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `rinconlivias`
--
CREATE DATABASE IF NOT EXISTS `rinconlivias` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `rinconlivias`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id_carrito` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `carrito`
--

INSERT INTO `carrito` (`id_carrito`, `cantidad`, `sub_total`, `id_cliente`, `id_empleado`, `id_producto`) VALUES
(64, 1, 8.00, NULL, 3, 3),
(65, 1, 21.00, NULL, 3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id_categoria` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id_categoria`, `nombre`) VALUES
(1, 'Entrada'),
(2, 'Plato Principal'),
(3, 'Bebida'),
(4, 'Postre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `activo` tinyint(4) DEFAULT 1,
  `apellido` varchar(50) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `direccion` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL,
  `fecha_creacion` date DEFAULT curdate(),
  `nombre` varchar(50) NOT NULL,
  `telefono` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `activo`, `apellido`, `clave`, `direccion`, `email`, `fecha_creacion`, `nombre`, `telefono`) VALUES
(1, 1, 'Castillo', '1234', 'MI casa xddd', 'dani@gmail.com', '2024-10-04', 'Daniel', '21323566');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id_comentario` int(11) NOT NULL,
  `calificacion` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `id_cliente` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante`
--

CREATE TABLE `comprobante` (
  `id_comprobante` int(11) NOT NULL,
  `estado` varchar(25) DEFAULT 'Emitido',
  `fecha_emision` timestamp NULL DEFAULT current_timestamp(),
  `igv` decimal(10,2) NOT NULL,
  `metodo_pago` varchar(25) NOT NULL,
  `numero_comprobante` varchar(50) NOT NULL,
  `razon_social` varchar(100) NOT NULL,
  `ruc` int(11) NOT NULL,
  `tipo` varchar(20) NOT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `id_pago` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_pedido`
--

CREATE TABLE `detalle_pedido` (
  `id_detalle_pedido` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `descuento` decimal(10,2) DEFAULT 0.00,
  `estado` tinyint(4) DEFAULT 0,
  `nombre_producto` varchar(50) NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `sub_total` decimal(10,2) NOT NULL,
  `id_pedido` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `detalle_pedido`
--

INSERT INTO `detalle_pedido` (`id_detalle_pedido`, `cantidad`, `descuento`, `estado`, `nombre_producto`, `precio_unitario`, `sub_total`, `id_pedido`, `id_producto`) VALUES
(1, 3, NULL, 1, 'Ceviche', 21.00, 63.00, 1, 4),
(2, 1, NULL, 1, 'Aji de Gallina', 23.00, 23.00, 2, 1),
(3, 1, NULL, 1, 'Anticuchos', 14.00, 14.00, 3, 2),
(4, 1, NULL, 1, 'Arroz con leche', 8.00, 8.00, 4, 3),
(5, 6, NULL, 1, 'Arroz con leche', 8.00, 48.00, 5, 3),
(6, 5, NULL, 1, 'Maracuyá', 8.00, 40.00, 5, 9),
(7, 2, NULL, 1, 'Rocoto Relleno', 23.00, 46.00, 5, 11),
(8, 2, NULL, 1, 'Anticuchos', 14.00, 28.00, 5, 2),
(9, 7, NULL, 1, 'Arroz con leche', 8.00, 56.00, 6, 3),
(10, 5, NULL, 1, 'Maracuyá', 8.00, 40.00, 6, 9),
(11, 2, NULL, 1, 'Rocoto Relleno', 23.00, 46.00, 6, 11),
(12, 2, NULL, 1, 'Anticuchos', 14.00, 28.00, 6, 2),
(13, 1, NULL, 1, 'Chicha', 7.00, 7.00, 7, 5),
(14, 1, NULL, 1, 'Ceviche', 21.00, 21.00, 8, 4),
(15, 2, NULL, 1, 'Ceviche', 21.00, 42.00, 9, 4),
(16, 1, NULL, 1, 'Lomo Saltado', 32.00, 32.00, 9, 8),
(17, 2, NULL, 1, 'Tres leches', 11.00, 22.00, 10, 12),
(18, 3, NULL, 1, 'Anticuchos', 14.00, 42.00, 10, 2),
(19, 3, NULL, 0, 'Chicha', 7.00, 21.00, 11, 5),
(20, 2, NULL, 0, 'Causa Limeña', 15.00, 30.00, 11, 6),
(21, 1, NULL, 0, 'Limonada', 8.00, 8.00, 11, 7),
(22, 1, NULL, 0, 'Lomo Saltado', 32.00, 32.00, 11, 8),
(23, 2, NULL, 1, 'Maracuyá', 8.00, 16.00, 12, 9),
(24, 1, NULL, 1, 'Anticuchos', 14.00, 14.00, 12, 2),
(25, 1, NULL, 1, 'Lomo Saltado', 32.00, 32.00, 12, 8),
(26, 2, NULL, 0, 'Aji de Gallina', 23.00, 46.00, 13, 1),
(27, 1, NULL, 0, 'Anticuchos', 14.00, 14.00, 13, 2),
(28, 2, NULL, 0, 'Maracuyá', 8.00, 16.00, 14, 9),
(29, 1, NULL, 0, 'Rocoto Relleno', 23.00, 23.00, 14, 11),
(30, 1, NULL, 0, 'Mazamorra morada', 14.00, 14.00, 14, 10),
(31, 1, NULL, 0, 'Limonada', 8.00, 8.00, 14, 7),
(32, 1, NULL, 0, 'Lomo Saltado', 32.00, 32.00, 14, 8),
(33, 1, NULL, 0, 'Mazamorra morada', 14.00, 14.00, 15, 10),
(34, 2, NULL, 0, 'Anticuchos', 14.00, 28.00, 15, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `dia`
--

CREATE TABLE `dia` (
  `id_dia` int(11) NOT NULL,
  `nombre` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `dia`
--

INSERT INTO `dia` (`id_dia`, `nombre`) VALUES
(1, 'Lunes'),
(2, 'Martes'),
(3, 'Miércoles'),
(4, 'Jueves'),
(5, 'Viernes'),
(6, 'Sábado'),
(7, 'Domingo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `id_empleado` int(11) NOT NULL,
  `activo` tinyint(4) DEFAULT 1,
  `apellido` varchar(50) NOT NULL,
  `clave` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `fecha_contratacion` date DEFAULT curdate(),
  `imagen` varchar(100) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `salario` decimal(10,2) DEFAULT 0.00,
  `telefono` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `activo`, `apellido`, `clave`, `email`, `fecha_contratacion`, `imagen`, `nombre`, `salario`, `telefono`) VALUES
(1, 1, 'Gomez', '1234', 'cami@gmail.com', '2024-10-04', 'Persona03.jpg', 'Camila01', 1200.00, '123456789'),
(2, 0, 'Torres', '1234', 'Torres@gmail.com', '2024-09-30', 'Persona02.jpg', 'Miguel', 1500.00, '123456789'),
(3, 1, 'Lopez', '1234', 'Lopez@gmail.com', '2024-09-30', 'Persona01.jpg', 'Raul', 1400.00, '123456789'),
(4, 0, 'vila', '1234', 'roberto@gmail.com', '2024-09-28', 'DefaultEmpleado.jpg', 'Roberto', 2300.00, '76275245374'),
(5, 1, 'Fernandez', '1234', 'carlos@gmail.com', '2024-09-28', 'DefaultEmpleado.jpg', 'Carlos', 2300.00, '762752442'),
(6, 0, 'Reyes', '1234', 'prueba04@gmail.com', '2024-09-20', 'DefaultEmpleado.jpg', 'Lucas', 2300.00, '1232456789'),
(7, 0, 'Reyes', '1234', 'prueba05@gmail.com', '2024-09-20', 'DefaultEmpleado.jpg', 'Lucas', 2300.00, '1232456789'),
(8, 1, 'vdsvds', '1234', 'prueba@gmail.com', '2024-09-26', 'DefaultEmpleado.jpg', 'vdsv', 1224.00, '2135651'),
(9, 0, 'Diaz', '1234', 'GeDiaz@gmail.com', '2024-10-01', 'DefaultEmpleado.jpg', 'Gerardo02', 42.00, '7627524537413'),
(10, 1, 'sefefs', '242', 'prueba03@gmail.com', '2024-10-04', 'DefaultEmpleado.jpg', 'fse', 12342.00, '76275245374'),
(11, 1, 'bdg', '1234', 'prueba02@gmail.com', '2024-10-02', 'DefaultEmpleado.jpg', 'bsdbfd', 234.00, '324'),
(12, 1, 'Livias', '23', 'vil@gmail.com', '2024-10-02', 'Foto.jpg', 'Alex', 235.00, '235'),
(13, 1, 'Guzman', '1234', '124534@gmail.com', '2024-10-02', 'DefaultEmpleado.jpg', 'Alberto', 2425.00, '1324567'),
(14, 1, 'Sanchez', '1234', 'feli@gmail.com', '2024-09-25', 'DefaultEmpleado.jpg', 'Felipe', 5700.00, '76564534652');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `menudia`
--

CREATE TABLE `menudia` (
  `id_menu` int(11) NOT NULL,
  `id_dia` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `menudia`
--

INSERT INTO `menudia` (`id_menu`, `id_dia`, `id_producto`) VALUES
(8, 1, 1),
(4, 2, 1),
(1, 3, 1),
(3, 1, 2),
(10, 1, 3),
(11, 1, 4),
(22, 2, 4),
(12, 1, 5),
(5, 3, 5),
(13, 1, 6),
(14, 1, 7),
(15, 1, 8),
(16, 1, 9),
(17, 1, 10),
(18, 1, 11),
(21, 2, 11),
(20, 6, 11),
(19, 1, 12);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mesa`
--

CREATE TABLE `mesa` (
  `id_mesa` int(11) NOT NULL,
  `activo` tinyint(4) DEFAULT 1,
  `capacidad` int(11) NOT NULL,
  `estado` varchar(20) DEFAULT 'Disponible',
  `numero_mesa` int(11) NOT NULL,
  `piso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mesa`
--

INSERT INTO `mesa` (`id_mesa`, `activo`, `capacidad`, `estado`, `numero_mesa`, `piso`) VALUES
(3, 1, 2, 'Disponible', 3, 1),
(4, 1, 3, 'Disponible', 4, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `estado` varchar(20) DEFAULT 'Pendiente',
  `fecha` timestamp NULL DEFAULT current_timestamp(),
  `metodo_pago` varchar(50) NOT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `referencia_pasarela` varchar(100) NOT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_pedido` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedido`
--

CREATE TABLE `pedido` (
  `id_pedido` int(11) NOT NULL,
  `estado` varchar(25) DEFAULT 'Pendiente',
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `tipo` varchar(25) NOT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `id_cliente` int(11) DEFAULT NULL,
  `id_empleado` int(11) DEFAULT NULL,
  `id_mesa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pedido`
--

INSERT INTO `pedido` (`id_pedido`, `estado`, `fecha_creacion`, `tipo`, `total`, `id_cliente`, `id_empleado`, `id_mesa`) VALUES
(1, 'Entregado', '2024-10-20 01:27:18', 'Local', 63.00, NULL, 3, NULL),
(2, 'Entregado', '2024-10-20 01:11:00', 'Local', 23.00, NULL, 3, NULL),
(3, 'Entregado', '2024-10-20 01:07:38', 'Online', 14.00, 1, NULL, NULL),
(4, 'Entregado', '2024-10-20 03:16:00', 'Online', 8.00, 1, NULL, NULL),
(5, 'Entregado', '2024-10-20 03:23:03', 'Online', 162.00, 1, NULL, NULL),
(6, 'Entregado', '2024-10-20 03:27:32', 'Online', 170.00, 1, NULL, NULL),
(7, 'Entregado', '2024-10-20 03:30:26', 'Online', 7.00, 1, NULL, NULL),
(8, 'Entregado', '2024-10-20 03:30:58', 'Online', 21.00, 1, NULL, NULL),
(9, 'Entregado', '2024-10-20 04:01:30', 'Online', 74.00, 1, NULL, NULL),
(10, 'Entregado', '2024-10-20 04:02:31', 'Online', 64.00, 1, NULL, NULL),
(11, 'Cancelado', '2024-10-20 04:16:33', 'Online', 91.00, 1, NULL, NULL),
(12, 'Entregado', '2024-10-20 04:22:18', 'Online', 62.00, 1, NULL, NULL),
(13, 'Pendiente', '2024-10-24 01:32:36', 'Local', 60.00, NULL, 3, NULL),
(14, 'Pendiente', '2024-10-24 01:38:39', 'Local', 93.00, NULL, 3, NULL),
(15, 'Pendiente', '2024-10-24 01:43:50', 'Local', 42.00, NULL, 3, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `producto`
--

CREATE TABLE `producto` (
  `id_producto` int(11) NOT NULL,
  `activo` tinyint(4) DEFAULT 1,
  `calificacion` int(11) DEFAULT 1,
  `descripcion` text NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `precio` decimal(10,2) DEFAULT 0.00,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `activo`, `calificacion`, `descripcion`, `imagen`, `nombre`, `precio`, `id_categoria`) VALUES
(1, 1, 3, 'Un guiso a base de pollo desmenuzado, cocido en una crema de ají amarillo, nueces y queso, servido con arroz y decorado con aceitunas y huevo duro.', 'ajiGallina.jpg', 'Aji de Gallina', 23.00, 2),
(2, 1, 5, 'Brochetas de corazón de res marinadas y asadas a la parrilla, tradicionalmente acompañadas de papas y una salsa de ají.', 'Anticuchos.jpg', 'Anticuchos', 14.00, 1),
(3, 1, 4, 'Un postre cremoso hecho con arroz, leche, azúcar, canela y pasas, servido frío o caliente.', 'arrozleche.jpg', 'Arroz con leche', 8.00, 4),
(4, 1, 5, 'Plato emblemático peruano que consiste en pescado crudo marinado en jugo de limón, sazonado con ají, cebolla y cilantro, acompañado de camote y maíz.', 'ceviche.jpg', 'Ceviche', 21.00, 2),
(5, 0, 4, 'Bebida tradicional peruana hecha a base de maíz fermentado, que puede ser dulce o amarga, y a menudo se sirve fría.', 'chicha.jpg', 'Chicha', 7.00, 3),
(6, 1, 3, 'Una deliciosa entrada hecha con puré de papa amarilla, ají amarillo y rellena de atún, pollo o mariscos, decorada con aguacate y aceitunas.', 'CLimeña.jpg', 'Causa Limeña', 15.00, 1),
(7, 1, 5, 'Bebida refrescante preparada con jugo de limón, agua, azúcar y a veces menta, ideal para combatir el calor.', 'limonada.jpg', 'Limonada', 8.00, 3),
(8, 1, 5, 'Un salteado de carne de res, cebolla, tomate y ají, servido con papas fritas y arroz, combinando influencias chinas y peruanas.', 'lomo.jpg', 'Lomo Saltado', 32.00, 2),
(9, 1, 4, 'Fruta tropical de sabor intenso, a menudo utilizada para hacer jugos, postres o salsas, conocida por su aroma y sabor distintivo.', 'maracuya.jpg', 'Maracuyá', 8.00, 3),
(10, 1, 4, 'Postre tradicional hecho con maíz morado, frutas secas, canela y clavos de olor, espeso y de color púrpura, generalmente servido con arroz con leche.', 'mazamorra.jpg', 'Mazamorra morada', 14.00, 4),
(11, 1, 4, 'Pimiento rocoto relleno de carne picada, cebolla, aceitunas y especias, cubierto con queso y horneado, típico de Arequipa.', 'rocoto.jpg', 'Rocoto Relleno', 23.00, 2),
(12, 1, 4, 'Pastel empapado en una mezcla de tres tipos de leche (leche evaporada, leche condensada y crema), suave y muy húmedo, ideal para los amantes de los postres cremosos.', 'tresleches.jpg', 'Tres leches', 11.00, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `id_rol` int(11) NOT NULL,
  `rol_nombre` varchar(25) NOT NULL,
  `id_empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`id_rol`, `rol_nombre`, `id_empleado`) VALUES
(10, 'Administrador', 1),
(7, 'Administrador', 2),
(15, 'Camarero', 3),
(1, 'Administrador', 5),
(2, 'Camarero', 6),
(16, 'Administrador', 10),
(17, 'Camarero', 11),
(18, 'Camarero', 12),
(19, 'Cocinero', 13),
(20, 'Cocinero', 14);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id_carrito`),
  ADD KEY `FKry3lix3gwxchdayl4i5sh7y4f` (`id_cliente`),
  ADD KEY `FKokufhmtd0fgw2u1hcjf7f0ndx` (`id_empleado`),
  ADD KEY `FK31bnxr8934wee44ihtfuwq2e2` (`id_producto`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id_categoria`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `FKddm2g09bkcq40w9t5ujk3i4y3` (`id_cliente`),
  ADD KEY `FKauvhsib9xfob0t4t0j4ylyt02` (`id_producto`);

--
-- Indices de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD PRIMARY KEY (`id_comprobante`),
  ADD UNIQUE KEY `UK1bg4vqkc3d75sgntebmqnvgx4` (`id_pago`);

--
-- Indices de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD PRIMARY KEY (`id_detalle_pedido`),
  ADD KEY `FK7n9hdifr08joboojejveby1vr` (`id_pedido`),
  ADD KEY `FKjfm9pk0w2eag8tx8lu6pbego6` (`id_producto`);

--
-- Indices de la tabla `dia`
--
ALTER TABLE `dia`
  ADD PRIMARY KEY (`id_dia`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`id_empleado`),
  ADD UNIQUE KEY `UKnihg474u49g6e8aolp4lwrj6e` (`email`);

--
-- Indices de la tabla `menudia`
--
ALTER TABLE `menudia`
  ADD PRIMARY KEY (`id_menu`),
  ADD UNIQUE KEY `UKnd8co7pcty1lhpqss9r5jybvh` (`id_producto`,`id_dia`),
  ADD KEY `FKpip86xmvi6ch7a0un0q3ho08t` (`id_dia`);

--
-- Indices de la tabla `mesa`
--
ALTER TABLE `mesa`
  ADD PRIMARY KEY (`id_mesa`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD UNIQUE KEY `UKsmd7sl0godm04hw83kdt6ebwf` (`id_pedido`),
  ADD KEY `FK2fmwlqws6jmrycdhkn2bl8m0p` (`id_cliente`);

--
-- Indices de la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD PRIMARY KEY (`id_pedido`),
  ADD KEY `FK9y4jnyp1hxqa386cnly0ay9uw` (`id_cliente`),
  ADD KEY `FKqbl4adl78gxdv0wbx3nq03awv` (`id_empleado`),
  ADD KEY `FK6vxat0l7c1d0enyrlij0fiyks` (`id_mesa`);

--
-- Indices de la tabla `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id_producto`),
  ADD KEY `FK9nyueixdsgbycfhf7allg8su` (`id_categoria`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`id_rol`),
  ADD UNIQUE KEY `UK4u9may7ut02op2yq5t763txv4` (`id_empleado`,`rol_nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  MODIFY `id_comprobante` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de la tabla `dia`
--
ALTER TABLE `dia`
  MODIFY `id_dia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `menudia`
--
ALTER TABLE `menudia`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `mesa`
--
ALTER TABLE `mesa`
  MODIFY `id_mesa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `FK31bnxr8934wee44ihtfuwq2e2` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `FKokufhmtd0fgw2u1hcjf7f0ndx` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`),
  ADD CONSTRAINT `FKry3lix3gwxchdayl4i5sh7y4f` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `FKauvhsib9xfob0t4t0j4ylyt02` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `FKddm2g09bkcq40w9t5ujk3i4y3` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`);

--
-- Filtros para la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD CONSTRAINT `FK6u8o36tk1d40kbkonc34l3115` FOREIGN KEY (`id_pago`) REFERENCES `pago` (`id_pago`);

--
-- Filtros para la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  ADD CONSTRAINT `FK7n9hdifr08joboojejveby1vr` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`),
  ADD CONSTRAINT `FKjfm9pk0w2eag8tx8lu6pbego6` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`);

--
-- Filtros para la tabla `menudia`
--
ALTER TABLE `menudia`
  ADD CONSTRAINT `FKmyux1hye45n9ttosiko2o40hl` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id_producto`),
  ADD CONSTRAINT `FKpip86xmvi6ch7a0un0q3ho08t` FOREIGN KEY (`id_dia`) REFERENCES `dia` (`id_dia`);

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `FK2fmwlqws6jmrycdhkn2bl8m0p` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `FKpddca3nqitclyep51ognpka70` FOREIGN KEY (`id_pedido`) REFERENCES `pedido` (`id_pedido`);

--
-- Filtros para la tabla `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `FK6vxat0l7c1d0enyrlij0fiyks` FOREIGN KEY (`id_mesa`) REFERENCES `mesa` (`id_mesa`),
  ADD CONSTRAINT `FK9y4jnyp1hxqa386cnly0ay9uw` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`),
  ADD CONSTRAINT `FKqbl4adl78gxdv0wbx3nq03awv` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);

--
-- Filtros para la tabla `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `FK9nyueixdsgbycfhf7allg8su` FOREIGN KEY (`id_categoria`) REFERENCES `categoria` (`id_categoria`);

--
-- Filtros para la tabla `rol`
--
ALTER TABLE `rol`
  ADD CONSTRAINT `FKi2ly3lao36f5cis1nhgsgw57g` FOREIGN KEY (`id_empleado`) REFERENCES `empleado` (`id_empleado`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
