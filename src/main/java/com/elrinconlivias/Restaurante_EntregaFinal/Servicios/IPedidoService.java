package com.elrinconlivias.Restaurante_EntregaFinal.Servicios;

import java.util.List;
import java.util.Optional;

import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Cliente;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Empleado;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Pedido;


public interface IPedidoService {
	List<Pedido> findAll();
	Optional<Pedido> findById(Integer id);
	Pedido save(Pedido orden);
	//String generarNumeroOrden();
	List<Pedido> findByCliente(Cliente cliente);
	List<Pedido> findByEmpleado(Empleado empleado);
	List<Pedido> findByEstado(String estado);
}
