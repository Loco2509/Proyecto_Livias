-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 05-12-2024 a las 02:31:08
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
  `telefono` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id_cliente`, `activo`, `apellido`, `clave`, `direccion`, `email`, `fecha_creacion`, `nombre`, `telefono`) VALUES
(1, 1, 'Castillo', '1234', 'MI casa xddd', 'dani@gmail.com', '2024-10-04', 'Daniel', '21323566'),
(2, 1, 'Livias', '1234', 'San Juan de Lurigancho', 'vila123@gmail.com', '2024-11-17', 'Gian', '123456789'),
(3, 0, 'vila', '$2a$10$9sqs8oMb0g7EoTldcffr7O1PkvDdi4iE10zuyx3Odhwd.mbVtIoOK', 'San Juan de Lurigancho', 'uncorreo@gmail.com', '2024-12-04', 'Alexander', '123456789'),
(4, 1, 'Gomez', '$2a$10$0HdtVWux6cZBZ4eDmnohpeI7XPRVv1bZbIxz/a3rYbd6DS4UEPPv6', 'San Juan de Lurigancho', 'feregre@gmail.com', '2024-12-04', 'Luisandro', '323323232');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id_comentario` int(11) NOT NULL,
  `calificacion` int(11) NOT NULL,
  `texto` text NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT current_timestamp(),
  `id_cliente` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`id_comentario`, `calificacion`, `texto`, `fecha_creacion`, `id_cliente`, `id_producto`) VALUES
(9, 4, 'Rico, pero le faltó más porciones.', '2024-11-17 10:50:34', 1, 2),
(10, 2, 'Me gustó el sabor, estaba jugoso y barato.', '2024-11-17 12:28:09', 2, 2),
(11, 3, 'No me gustó su sabor.', '2024-11-17 11:54:58', 2, 3),
(12, 4, 'Muy rico la verdad', '2024-11-23 10:26:17', 1, 3);

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
  `razon_social` varchar(100) DEFAULT NULL,
  `ruc` varchar(11) DEFAULT NULL,
  `tipo` varchar(20) NOT NULL,
  `monto_total` decimal(10,2) NOT NULL,
  `id_pago` int(11) NOT NULL,
  `dni` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comprobante`
--

INSERT INTO `comprobante` (`id_comprobante`, `estado`, `fecha_emision`, `igv`, `metodo_pago`, `numero_comprobante`, `razon_social`, `ruc`, `tipo`, `monto_total`, `id_pago`, `dni`) VALUES
(1, 'Pagado', '2024-11-17 15:18:41', 2.14, 'Tarjeta', '-000001', NULL, '0', 'Boleta', 14.00, 43, NULL),
(2, 'Pagado', '2024-11-17 15:26:50', 2.14, 'Tarjeta', 'B001-000002', NULL, '0', 'Boleta', 14.00, 44, NULL),
(3, 'Pagado', '2024-11-17 15:27:17', 2.14, 'Tarjeta', 'B001-000003', NULL, '0', 'Boleta', 14.00, 45, NULL),
(4, 'Pagado', '2024-11-17 15:29:23', 2.14, 'Tarjeta', 'B001-000004', NULL, '0', 'Boleta', 14.00, 46, NULL),
(5, 'Pagado', '2024-11-17 15:30:26', 2.14, 'Tarjeta', 'B001-000005', NULL, '0', 'Boleta', 14.00, 47, NULL),
(6, 'Pagado', '2024-11-17 15:30:45', 0.00, 'Tarjeta', 'B001-000006', NULL, '0', 'Boleta', 0.00, 48, NULL),
(7, 'Pagado', '2024-11-17 15:31:50', 0.00, 'Tarjeta', 'B001-000007', NULL, '0', 'Boleta', 0.00, 49, NULL),
(8, 'Pagado', '2024-11-17 15:32:43', 0.00, 'Tarjeta', 'B001-000008', NULL, '0', 'Boleta', 0.00, 50, NULL),
(9, 'Pagado', '2024-11-17 15:33:32', 3.20, 'Tarjeta', 'B001-000009', NULL, '0', 'Boleta', 21.00, 51, NULL),
(10, 'Pagado', '2024-11-23 10:29:54', 4.88, 'Tarjeta', 'B001-000010', NULL, '0', 'Boleta', 32.00, 52, NULL),
(11, 'Pagado', '2024-11-23 10:33:21', 4.88, 'Tarjeta', 'B001-000011', NULL, '0', 'Boleta', 32.00, 53, NULL),
(12, 'Pagado', '2024-11-23 10:34:55', 2.14, 'Tarjeta', 'B001-000012', NULL, '0', 'Boleta', 14.00, 54, NULL),
(13, 'Pagado', '2024-11-23 10:37:03', 3.20, 'Tarjeta', 'B001-000013', NULL, '0', 'Boleta', 21.00, 55, NULL),
(14, 'Pagado', '2024-11-23 10:44:15', 3.51, 'Tarjeta', 'B001-000014', NULL, '0', 'Boleta', 23.00, 56, NULL),
(15, 'Pagado', '2024-11-23 11:03:03', 2.14, 'Tarjeta', 'B001-000015', NULL, '0', 'Boleta', 14.00, 57, NULL),
(17, 'Pagado', '2024-11-23 11:13:45', 14.80, 'Tarjeta', 'B001-000016', NULL, '0', 'Boleta', 97.00, 59, NULL),
(18, 'Pagado', '2024-11-23 11:39:35', 0.00, 'Tarjeta', '-000001', 'Empresa anonima SAC', '12345678901', 'Factura', 0.00, 65, NULL),
(19, 'Pagado', '2024-11-23 11:40:15', 4.27, 'Tarjeta', 'F001-000002', 'Empresa anonima SAC', '12345678901', 'Factura', 28.00, 66, NULL),
(20, 'Pagado', '2024-11-23 11:44:57', 2.44, 'Tarjeta', 'B001-000017', NULL, NULL, 'Boleta', 16.00, 68, NULL),
(21, 'Pagado', '2024-11-23 11:55:44', 4.88, 'Tarjeta', 'B001-000018', NULL, NULL, 'Boleta', 32.00, 69, NULL),
(22, 'Pagado', '2024-11-23 11:59:04', 4.27, 'Tarjeta', 'B001-000019', NULL, NULL, 'Boleta', 28.00, 70, NULL),
(23, 'Pagado', '2024-12-05 00:45:31', 6.41, 'Tarjeta', 'B001-000020', NULL, NULL, 'Boleta', 42.00, 71, NULL),
(24, 'Pagado', '2024-12-05 00:53:19', 1.22, 'Tarjeta', 'B001-000021', NULL, NULL, 'Boleta', 8.00, 72, NULL),
(25, 'Pagado', '2024-12-05 00:56:44', 8.08, 'Tarjeta', 'B001-000022', NULL, NULL, 'Boleta', 53.00, 73, '12345678');

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
(26, 2, NULL, 1, 'Aji de Gallina', 23.00, 46.00, 13, 1),
(27, 1, NULL, 1, 'Anticuchos', 14.00, 14.00, 13, 2),
(28, 2, NULL, 1, 'Maracuyá', 8.00, 16.00, 14, 9),
(29, 1, NULL, 1, 'Rocoto Relleno', 23.00, 23.00, 14, 11),
(30, 1, NULL, 1, 'Mazamorra morada', 14.00, 14.00, 14, 10),
(31, 1, NULL, 1, 'Limonada', 8.00, 8.00, 14, 7),
(32, 1, NULL, 1, 'Lomo Saltado', 32.00, 32.00, 14, 8),
(33, 1, NULL, 1, 'Mazamorra morada', 14.00, 14.00, 15, 10),
(34, 2, NULL, 1, 'Anticuchos', 14.00, 28.00, 15, 2),
(35, 1, NULL, 0, 'Limonada', 8.00, 8.00, 24, 7),
(36, 2, NULL, 0, 'Rocoto Relleno', 23.00, 46.00, 24, 11),
(37, 3, NULL, 0, 'Arroz con leche', 8.00, 24.00, 24, 3),
(38, 1, NULL, 0, 'Arroz con leche', 8.00, 8.00, 26, 3),
(39, 1, NULL, 0, 'Ceviche', 21.00, 21.00, 27, 4),
(40, 1, NULL, 0, 'Arroz con leche', 8.00, 8.00, 29, 3),
(41, 2, NULL, 0, 'Arroz con leche', 8.00, 16.00, 30, 3),
(42, 1, NULL, 0, 'Arroz con leche', 8.00, 8.00, 33, 3),
(43, 2, NULL, 0, 'Ceviche', 21.00, 42.00, 34, 4),
(44, 1, NULL, 0, 'Arroz con leche', 8.00, 8.00, 34, 3),
(45, 4, NULL, 1, 'Arroz con leche', 8.00, 32.00, 35, 3),
(46, 7, NULL, 1, 'Ceviche', 21.00, 147.00, 35, 4),
(47, 2, NULL, 1, 'Anticuchos', 14.00, 28.00, 35, 2),
(48, 3, NULL, 0, 'Arroz con leche', 8.00, 24.00, 36, 3),
(49, 3, NULL, 0, 'Arroz con leche', 8.00, 24.00, 38, 3),
(50, 3, NULL, 0, 'Arroz con leche', 8.00, 24.00, 39, 3),
(51, 2, NULL, 0, 'Aji de Gallina', 23.00, 46.00, 39, 1),
(52, 2, NULL, 0, 'Anticuchos', 14.00, 28.00, 40, 2),
(53, 3, NULL, 0, 'Ceviche', 21.00, 63.00, 41, 4),
(54, 2, NULL, 0, 'Arroz con leche', 8.00, 16.00, 42, 3),
(55, 1, NULL, 0, 'Arroz con leche', 8.00, 8.00, 43, 3),
(56, 1, NULL, 0, 'Rocoto Relleno', 23.00, 23.00, 44, 11),
(57, 2, NULL, 0, 'Anticuchos', 14.00, 28.00, 45, 2),
(58, 1, NULL, 0, 'Anticuchos', 14.00, 14.00, 54, 2),
(59, 1, NULL, 0, 'Ceviche', 21.00, 21.00, 58, 4),
(60, 4, NULL, 0, 'Arroz con leche', 8.00, 32.00, 60, 3),
(61, 1, NULL, 0, 'Anticuchos', 14.00, 14.00, 61, 2),
(62, 1, NULL, 0, 'Ceviche', 21.00, 21.00, 62, 4),
(63, 1, NULL, 0, 'Aji de Gallina', 23.00, 23.00, 63, 1),
(64, 1, NULL, 0, 'Anticuchos', 14.00, 14.00, 64, 2),
(65, 3, NULL, 0, 'Mazamorra morada', 14.00, 42.00, 65, 10),
(66, 2, NULL, 0, 'Ceviche', 21.00, 42.00, 65, 4),
(67, 2, NULL, 0, 'Causa Limeña', 15.00, 30.00, 65, 6),
(68, 2, NULL, 0, 'Anticuchos', 14.00, 28.00, 65, 2),
(69, 3, NULL, 0, 'Causa Limeña', 15.00, 45.00, 66, 6),
(70, 2, NULL, 0, 'Limonada', 8.00, 16.00, 66, 7),
(71, 4, NULL, 0, 'Chicha', 7.00, 28.00, 66, 5),
(72, 1, NULL, 0, 'Maracuyá', 8.00, 8.00, 66, 9),
(73, 2, NULL, 0, 'Arroz con leche', 8.00, 16.00, 67, 3),
(74, 2, NULL, 0, 'Anticuchos', 14.00, 28.00, 70, 2),
(75, 2, NULL, 0, 'Arroz con leche', 8.00, 16.00, 71, 3),
(76, 4, NULL, 0, 'Arroz con leche', 8.00, 32.00, 72, 3),
(77, 2, NULL, 0, 'Anticuchos', 14.00, 28.00, 73, 2),
(78, 3, NULL, 0, 'Anticuchos', 14.00, 42.00, 74, 2),
(79, 3, NULL, 0, 'Anticuchos', 14.00, 42.00, 75, 2),
(80, 1, NULL, 0, 'Arroz con leche', 8.00, 8.00, 76, 3),
(81, 1, NULL, 0, 'Tres leches', 11.00, 11.00, 77, 12),
(82, 2, NULL, 0, 'Ceviche', 21.00, 42.00, 77, 4);

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
  `salario` decimal(10,2) NOT NULL DEFAULT 0.00,
  `telefono` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`id_empleado`, `activo`, `apellido`, `clave`, `email`, `fecha_contratacion`, `imagen`, `nombre`, `salario`, `telefono`) VALUES
(1, 1, 'Gomez', '$2a$10$Jtc1SgYQNBL90sAjYO49BuTAn2KIoXLuTsRc1P7N1auV/wwCeHuQm', 'cami@gmail.com', '2024-10-04', 'Persona03.jpg', 'Camila', 1200.00, '123456789'),
(2, 0, 'Torres', '1234', 'Torres@gmail.com', '2024-09-30', 'Persona02.jpg', 'Miguel', 1500.00, '123456789'),
(3, 1, 'Lopez', '$2a$10$JACuLMXsaBQ5tLWf4xDD8uoRu5ZyR4YMPmjSGtYECvCz29ocZraOq', 'Lopez@gmail.com', '2024-09-30', 'Persona01.jpg', 'Raul', 1400.00, '123456789'),
(4, 0, 'vila', '1234', 'roberto@gmail.com', '2024-09-28', 'DefaultEmpleado.jpg', 'Roberto', 2300.00, '76275245374'),
(5, 1, 'Fernandez', '$2a$10$0FszB.tv/SooIhQiKCJ.sOtc1hIwRpA5vwvO77Cy0hkKLfsiAr4ma', 'carlos@gmail.com', '2024-09-28', 'DefaultEmpleado.jpg', 'Carlos', 2300.00, '762752442'),
(6, 0, 'Reyes', '1234', 'prueba04@gmail.com', '2024-09-20', 'DefaultEmpleado.jpg', 'Lucas', 2300.00, '1232456789'),
(7, 0, 'Reyes', '1234', 'prueba05@gmail.com', '2024-09-20', 'DefaultEmpleado.jpg', 'Lucas', 2300.00, '1232456789'),
(8, 1, 'vdsvds', '$2a$10$.DJ31fkn9UAipEIE3zQgd.DZK3f2UMUYlLUacB1NGcPSIoXv61wu6', 'prueba@gmail.com', '2024-09-26', 'DefaultEmpleado.jpg', 'vdsv', 1224.00, '213565142'),
(9, 0, 'Diaz', '1234', 'GeDiaz@gmail.com', '2024-10-01', 'DefaultEmpleado.jpg', 'Gerardo02', 42.00, '7627524537413'),
(10, 1, 'sefefs', '$2a$10$N6w6Hnmb2khvMsnngHO4WuHXa/H0T/aucuMEn4Ru7qI33dRmr45Ea', 'prueba03@gmail.com', '2024-10-04', 'DefaultEmpleado.jpg', 'fse', 12342.00, '762752453'),
(11, 1, 'bdg', '$2a$10$beumr6Hou7KWK7jZy./TdezCRrZ2IoTQ6HepnTNKLx50cSgfRPQXq', 'prueba02@gmail.com', '2024-10-02', 'DefaultEmpleado.jpg', 'bsdbfd', 234.00, '324323253'),
(12, 1, 'Livias', '$2a$10$TOyqqEbeh8k2xT73RZER0uCnjTfBb.uoGR8O6WubhX5SJV5TOYguy', 'vil@gmail.com', '2024-10-02', 'Foto.jpg', 'Alex', 235.00, '235322324'),
(13, 1, 'Guzman', '$2a$10$eEO5N0OJDaHOgFN59S.6Cef6u9O0geOEoPnS86/JCrNEv6POEAGSu', '124534@gmail.com', '2024-10-02', 'DefaultEmpleado.jpg', 'Alberto', 2425.00, '132456723'),
(14, 1, 'Sanchez', '$2a$10$/v7RsC0MX.sHpdFPa7msuOCrATifQErai6eeTJOd11OULN68IER7C', 'feli@gmail.com', '2024-09-25', 'DefaultEmpleado.jpg', 'Felipe', 5700.00, '765645344'),
(15, 1, 'Lara', '$2a$10$BLuRJ.YjbGFVMtNJ0zO1sOAU0iJtrxeedsPtwjC6fySZrQ6rYXCHe', 'Tolar@gmail.com', '2024-12-04', 'DefaultEmpleado.jpg', 'Toreto Lara', 1200.00, '964738199');

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
(29, 1, 1),
(4, 2, 1),
(1, 3, 1),
(8, 6, 1),
(3, 4, 2),
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
(28, 1, 12);

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
(3, 1, 2, 'Ocupado', 3, 1),
(4, 1, 3, 'Disponible', 4, 2),
(5, 1, 4, 'Disponible', 5, 2),
(6, 1, 5, 'Disponible', 6, 1);

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
  `referencia_pasarela` varchar(100) NOT NULL DEFAULT '',
  `id_cliente` int(11) DEFAULT NULL,
  `id_pedido` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`id_pago`, `estado`, `fecha`, `metodo_pago`, `monto_total`, `referencia_pasarela`, `id_cliente`, `id_pedido`) VALUES
(16, 'Terminado', '2024-10-28 06:45:08', 'Tarjeta', 0.00, 'REF-048d7602-a', NULL, 31),
(17, 'Terminado', '2024-10-28 06:45:24', 'Tarjeta', 0.00, 'REF-b3b5364b-1', NULL, 32),
(18, 'Terminado', '2024-10-28 06:49:35', 'Tarjeta', 8.00, 'REF-e8d186b6-d', NULL, 33),
(19, 'Terminado', '2024-10-28 07:31:41', 'Tarjeta', 50.00, 'REF-f97d468b-6', 1, 34),
(21, 'Terminado', '2024-10-28 08:40:42', 'Tarjeta', 24.00, 'REF-8c761ce9-8', 1, 36),
(22, 'Terminado', '2024-10-28 08:42:08', 'Tarjeta', 0.00, 'REF-503e006d-6', 1, 37),
(23, 'Terminado', '2024-10-28 08:43:21', 'Tarjeta', 24.00, 'REF-af319982-9', 1, 38),
(24, 'Terminado', '2024-10-28 11:16:35', 'Efectivo', 60.00, 'REF-b6b6244f-9', NULL, 13),
(26, 'Terminado', '2024-10-28 11:16:50', 'Tarjeta', 63.00, 'REF-9382bd90-d', NULL, 1),
(29, 'Terminado', '2024-10-28 11:22:13', 'Efectivo', 23.00, 'REF-dca6c183-e', NULL, 2),
(32, 'Terminado', '2024-10-28 11:23:39', 'Tarjeta', 93.00, 'REF-b728cf14-f', NULL, 14),
(33, 'Terminado', '2024-10-28 11:25:43', 'Efectivo', 42.00, 'REF-2a29fcc4-9', NULL, 15),
(34, 'Terminado', '2024-10-28 11:26:33', 'Tarjeta', 207.00, 'REF-4c6b0beb-3', NULL, 35),
(35, 'Terminado', '2024-11-16 03:01:59', 'Tarjeta', 8.00, 'REF-bfa15951-8', 1, 43),
(36, 'Terminado', '2024-11-17 12:55:13', 'Tarjeta', 23.00, 'REF-feaad256-b', 2, 44),
(37, 'Terminado', '2024-11-17 15:01:16', 'Tarjeta', 28.00, 'REF-63449f0d-d', 1, 45),
(39, 'Terminado', '2024-11-17 15:05:11', 'Tarjeta', 0.00, 'REF-3fe0151d-b', 1, 46),
(40, 'Terminado', '2024-11-17 15:08:16', 'Tarjeta', 0.00, 'REF-96e359c8-4', 1, 47),
(41, 'Terminado', '2024-11-17 15:13:28', 'Tarjeta', 0.00, 'REF-5fd8bf84-6', 1, 48),
(42, 'Terminado', '2024-11-17 15:14:57', 'Tarjeta', 0.00, 'REF-1df0a4ad-1', 1, 49),
(43, 'Terminado', '2024-11-17 15:18:41', 'Tarjeta', 14.00, 'REF-d15ad6be-1', 1, 50),
(44, 'Terminado', '2024-11-17 15:26:50', 'Tarjeta', 14.00, 'REF-46ca661c-3', 1, 51),
(45, 'Terminado', '2024-11-17 15:27:17', 'Tarjeta', 14.00, 'REF-0b376c26-6', 1, 52),
(46, 'Terminado', '2024-11-17 15:29:23', 'Tarjeta', 14.00, 'REF-3228257c-5', 1, 53),
(47, 'Terminado', '2024-11-17 15:30:26', 'Tarjeta', 14.00, 'REF-30bb5142-3', 1, 54),
(48, 'Terminado', '2024-11-17 15:30:45', 'Tarjeta', 0.00, 'REF-440a024e-f', 1, 55),
(49, 'Terminado', '2024-11-17 15:31:50', 'Tarjeta', 0.00, 'REF-58b4d250-f', 1, 56),
(50, 'Terminado', '2024-11-17 15:32:43', 'Tarjeta', 0.00, 'REF-cf1809d7-2', 1, 57),
(51, 'Terminado', '2024-11-17 15:33:32', 'Tarjeta', 21.00, 'REF-c8f5f6de-0', 1, 58),
(52, 'Terminado', '2024-11-23 10:29:54', 'Tarjeta', 32.00, 'REF-d88ec48a-2', 1, 59),
(53, 'Terminado', '2024-11-23 10:33:20', 'Tarjeta', 32.00, 'REF-ca2e0e75-0', 1, 60),
(54, 'Terminado', '2024-11-23 10:34:55', 'Tarjeta', 14.00, 'REF-f7bc6c11-f', 1, 61),
(55, 'Terminado', '2024-11-23 10:37:03', 'Tarjeta', 21.00, 'REF-6fb54a19-9', 1, 62),
(56, 'Terminado', '2024-11-23 10:44:14', 'Tarjeta', 23.00, 'REF-3999c5f3-2', 1, 63),
(57, 'Terminado', '2024-11-23 11:03:03', 'Tarjeta', 14.00, 'REF-7d3bac6a-a', 1, 64),
(58, 'Terminado', '2024-11-23 11:06:38', 'Tarjeta', 142.00, 'REF-68844ed4-b', 1, 65),
(59, 'Terminado', '2024-11-23 11:13:45', 'Tarjeta', 97.00, 'REF-db9c6ddb-6', 1, 66),
(60, 'Terminado', '2024-11-23 11:35:32', 'Tarjeta', 16.00, 'REF-74e3dcc5-2', 1, 67),
(64, 'Terminado', '2024-11-23 11:36:22', 'Tarjeta', 0.00, 'REF-93370bc7-8', 1, 68),
(65, 'Terminado', '2024-11-23 11:39:35', 'Tarjeta', 0.00, 'REF-2954fedd-2', 1, 69),
(66, 'Terminado', '2024-11-23 11:40:15', 'Tarjeta', 28.00, 'REF-639a442b-a', 1, 70),
(68, 'Terminado', '2024-11-23 11:44:57', 'Tarjeta', 16.00, 'REF-2de4827e-e', 1, 71),
(69, 'Terminado', '2024-11-23 11:55:44', 'Tarjeta', 32.00, 'REF-88d69885-8', 1, 72),
(70, 'Terminado', '2024-11-23 11:59:04', 'Tarjeta', 28.00, 'REF-82cfb3ea-e', 1, 73),
(71, 'Terminado', '2024-12-05 00:45:30', 'Tarjeta', 42.00, 'REF-499b7e0d-6', 3, 75),
(72, 'Terminado', '2024-12-05 00:53:19', 'Tarjeta', 8.00, 'REF-cc91de41-d', 3, 76),
(73, 'Terminado', '2024-12-05 00:56:44', 'Tarjeta', 53.00, 'REF-876eb4aa-3', 3, 77);

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
(1, 'Terminado', '2024-10-20 01:27:18', 'Local', 63.00, NULL, 3, NULL),
(2, 'Terminado', '2024-10-20 01:11:00', 'Local', 23.00, NULL, 3, NULL),
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
(13, 'Terminado', '2024-10-24 01:32:36', 'Local', 60.00, NULL, 3, NULL),
(14, 'Terminado', '2024-10-24 01:38:39', 'Local', 93.00, NULL, 3, NULL),
(15, 'Terminado', '2024-10-24 01:43:50', 'Local', 42.00, NULL, 3, NULL),
(16, 'Pendiente', '2024-10-28 05:49:22', 'Online', 78.00, 1, NULL, NULL),
(17, 'Pendiente', '2024-10-28 05:49:31', 'Online', 78.00, 1, NULL, NULL),
(18, 'Pendiente', '2024-10-28 05:49:35', 'Online', 78.00, 1, NULL, NULL),
(19, 'Pendiente', '2024-10-28 05:50:28', 'Online', 78.00, 1, NULL, NULL),
(20, 'Pendiente', '2024-10-28 05:51:03', 'Online', 78.00, 1, NULL, NULL),
(21, 'Pendiente', '2024-10-28 05:53:37', 'Online', 78.00, 1, NULL, NULL),
(22, 'Pendiente', '2024-10-28 05:58:00', 'Online', 78.00, 1, NULL, NULL),
(23, 'Pendiente', '2024-10-28 05:58:13', 'Online', 78.00, 1, NULL, NULL),
(24, 'Pendiente', '2024-10-28 05:58:35', 'Online', 78.00, 1, NULL, NULL),
(25, 'Pendiente', '2024-10-28 06:00:12', 'Online', 8.00, 1, NULL, NULL),
(26, 'Pendiente', '2024-10-28 06:00:44', 'Online', 8.00, 1, NULL, NULL),
(27, 'Pendiente', '2024-10-28 06:01:41', 'Online', 21.00, 1, NULL, NULL),
(28, 'Pendiente', '2024-10-28 06:04:40', 'Online', 8.00, 1, NULL, NULL),
(29, 'Pendiente', '2024-10-28 06:09:09', 'Online', 8.00, 1, NULL, NULL),
(30, 'Pendiente', '2024-10-28 06:30:22', 'Online', 16.00, 1, NULL, NULL),
(31, 'Pendiente', '2024-10-28 06:45:08', 'Online', 0.00, 1, NULL, NULL),
(32, 'Pendiente', '2024-10-28 06:45:24', 'Online', 0.00, 1, NULL, NULL),
(33, 'Pendiente', '2024-10-28 06:49:35', 'Online', 8.00, 1, NULL, NULL),
(34, 'Pendiente', '2024-10-28 07:31:41', 'Online', 50.00, 1, NULL, NULL),
(35, 'Terminado', '2024-10-28 08:11:24', 'Local', 207.00, NULL, 3, 3),
(36, 'Pendiente', '2024-10-28 08:40:42', 'Online', 24.00, 1, NULL, NULL),
(37, 'Pendiente', '2024-10-28 08:42:08', 'Online', 0.00, 1, NULL, NULL),
(38, 'Pendiente', '2024-10-28 08:43:21', 'Online', 24.00, 1, NULL, NULL),
(39, 'Pendiente', '2024-10-28 08:52:29', 'Local', 70.00, NULL, 3, 3),
(40, 'Pendiente', '2024-10-28 10:23:07', 'Local', 28.00, NULL, 3, 3),
(41, 'Pendiente', '2024-10-28 10:23:30', 'Local', 63.00, NULL, 3, 4),
(42, 'Pendiente', '2024-10-28 10:44:35', 'Local', 16.00, NULL, 3, 3),
(43, 'Pendiente', '2024-11-16 03:01:59', 'Online', 8.00, 1, NULL, NULL),
(44, 'Pendiente', '2024-11-17 12:55:13', 'Online', 23.00, 2, NULL, NULL),
(45, 'Pendiente', '2024-11-17 15:01:16', 'Online', 28.00, 1, NULL, NULL),
(46, 'Pendiente', '2024-11-17 15:05:11', 'Online', 0.00, 1, NULL, NULL),
(47, 'Pendiente', '2024-11-17 15:08:16', 'Online', 0.00, 1, NULL, NULL),
(48, 'Pendiente', '2024-11-17 15:13:28', 'Online', 0.00, 1, NULL, NULL),
(49, 'Pendiente', '2024-11-17 15:14:57', 'Online', 0.00, 1, NULL, NULL),
(50, 'Pendiente', '2024-11-17 15:18:41', 'Online', 14.00, 1, NULL, NULL),
(51, 'Pendiente', '2024-11-17 15:26:50', 'Online', 14.00, 1, NULL, NULL),
(52, 'Pendiente', '2024-11-17 15:27:17', 'Online', 14.00, 1, NULL, NULL),
(53, 'Pendiente', '2024-11-17 15:29:23', 'Online', 14.00, 1, NULL, NULL),
(54, 'Pendiente', '2024-11-17 15:30:26', 'Online', 14.00, 1, NULL, NULL),
(55, 'Pendiente', '2024-11-17 15:30:45', 'Online', 0.00, 1, NULL, NULL),
(56, 'Pendiente', '2024-11-17 15:31:50', 'Online', 0.00, 1, NULL, NULL),
(57, 'Pendiente', '2024-11-17 15:32:43', 'Online', 0.00, 1, NULL, NULL),
(58, 'Pendiente', '2024-11-17 15:33:32', 'Online', 21.00, 1, NULL, NULL),
(59, 'Pendiente', '2024-11-23 10:29:54', 'Online', 32.00, 1, NULL, NULL),
(60, 'Pendiente', '2024-11-23 10:33:20', 'Online', 32.00, 1, NULL, NULL),
(61, 'Pendiente', '2024-11-23 10:34:55', 'Online', 14.00, 1, NULL, NULL),
(62, 'Pendiente', '2024-11-23 10:37:03', 'Online', 21.00, 1, NULL, NULL),
(63, 'Pendiente', '2024-11-23 10:44:15', 'Online', 23.00, 1, NULL, NULL),
(64, 'Pendiente', '2024-11-23 11:03:03', 'Online', 14.00, 1, NULL, NULL),
(65, 'Pendiente', '2024-11-23 11:06:38', 'Online', 142.00, 1, NULL, NULL),
(66, 'Pendiente', '2024-11-23 11:13:45', 'Online', 97.00, 1, NULL, NULL),
(67, 'Pendiente', '2024-11-23 11:35:32', 'Online', 16.00, 1, NULL, NULL),
(68, 'Pendiente', '2024-11-23 11:36:22', 'Online', 0.00, 1, NULL, NULL),
(69, 'Pendiente', '2024-11-23 11:39:35', 'Online', 0.00, 1, NULL, NULL),
(70, 'Pendiente', '2024-11-23 11:40:15', 'Online', 28.00, 1, NULL, NULL),
(71, 'Pendiente', '2024-11-23 11:44:57', 'Online', 16.00, 1, NULL, NULL),
(72, 'Pendiente', '2024-11-23 11:55:44', 'Online', 32.00, 1, NULL, NULL),
(73, 'Pendiente', '2024-11-23 11:59:04', 'Online', 28.00, 1, NULL, NULL),
(74, 'Pendiente', '2024-12-04 20:23:53', 'Local', 42.00, NULL, 3, 3),
(75, 'Pendiente', '2024-12-05 00:45:31', 'Online', 42.00, 3, NULL, NULL),
(76, 'Pendiente', '2024-12-05 00:53:19', 'Online', 8.00, 3, NULL, NULL),
(77, 'Pendiente', '2024-12-05 00:56:44', 'Online', 53.00, 3, NULL, NULL);

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
  `precio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `id_categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `producto`
--

INSERT INTO `producto` (`id_producto`, `activo`, `calificacion`, `descripcion`, `imagen`, `nombre`, `precio`, `id_categoria`) VALUES
(1, 1, 1, 'Un guiso a base de pollo desmenuzado, cocido en una crema de ají amarillo, nueces y queso, servido con arroz y decorado con aceitunas y huevo duro.', 'ajiGallina.jpg', 'Aji de Gallina', 23.00, 2),
(2, 1, 3, 'Brochetas de corazón de res marinadas y asadas a la parrilla, tradicionalmente acompañadas de papas y una salsa de ají.', 'Anticuchos.jpg', 'Anticuchos', 14.00, 1),
(3, 1, 4, 'Un postre cremoso hecho con arroz, leche, azúcar, canela y pasas, servido frío o caliente.', 'arrozleche.jpg', 'Arroz con leche', 8.00, 4),
(4, 1, 5, 'Plato emblemático peruano que consiste en pescado crudo marinado en jugo de limón, sazonado con ají, cebolla y cilantro, acompañado de camote y maíz.', 'ceviche.jpg', 'Ceviche', 21.00, 2),
(5, 0, 4, 'Bebida tradicional peruana hecha a base de maíz fermentado, que puede ser dulce o amarga, y a menudo se sirve fría.', 'chicha.jpg', 'Chicha', 7.00, 3),
(6, 1, 3, 'Una deliciosa entrada hecha con puré de papa amarilla, ají amarillo y rellena de atún, pollo o mariscos, decorada con aguacate y aceitunas.', 'CLimeña.jpg', 'Causa Limeña', 15.00, 1),
(7, 1, 5, 'Bebida refrescante preparada con jugo de limón, agua, azúcar y a veces menta, ideal para combatir el calor.', 'limonada.jpg', 'Limonada', 8.00, 3),
(8, 1, 5, 'Un salteado de carne de res, cebolla, tomate y ají, servido con papas fritas y arroz, combinando influencias chinas y peruanas.', 'lomo.jpg', 'Lomo Saltado', 32.00, 2),
(9, 1, 4, 'Fruta tropical de sabor intenso, a menudo utilizada para hacer jugos, postres o salsas, conocida por su aroma y sabor distintivo.', 'maracuya.jpg', 'Maracuyá', 8.00, 3),
(10, 1, 4, 'Postre tradicional hecho con maíz morado, frutas secas, canela y clavos de olor, espeso y de color púrpura, generalmente servido con arroz con leche.', 'mazamorra.jpg', 'Mazamorra morada', 14.00, 4),
(11, 1, 4, 'Pimiento rocoto relleno de carne picada, cebolla, aceitunas y especias, cubierto con queso y horneado, típico de Arequipa.', 'rocoto.jpg', 'Rocoto Relleno', 23.00, 2),
(12, 1, 4, 'Pastel empapado en una mezcla de tres tipos de leche (leche evaporada, leche condensada y crema), suave y muy húmedo, ideal para los amantes de los postres cremosos.', 'tresleches.jpg', 'Tres leches', 11.00, 4),
(13, 1, 1, 'Rico postre para la familia', 'alfajores.jpg', 'Alfajores', 12.00, 4),
(14, 0, 1, 'vererv', 'DefaultPlato.jpeg', 'frvevr', 24.00, 1);

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
(20, 'Cocinero', 14),
(21, 'Administrador', 15);

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
  MODIFY `id_carrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=173;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id_categoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `comentario`
--
ALTER TABLE `comentario`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  MODIFY `id_comprobante` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `detalle_pedido`
--
ALTER TABLE `detalle_pedido`
  MODIFY `id_detalle_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT de la tabla `dia`
--
ALTER TABLE `dia`
  MODIFY `id_dia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `id_empleado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `menudia`
--
ALTER TABLE `menudia`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de la tabla `mesa`
--
ALTER TABLE `mesa`
  MODIFY `id_mesa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `id_pago` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT de la tabla `pedido`
--
ALTER TABLE `pedido`
  MODIFY `id_pedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT de la tabla `producto`
--
ALTER TABLE `producto`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `rol`
--
ALTER TABLE `rol`
  MODIFY `id_rol` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
