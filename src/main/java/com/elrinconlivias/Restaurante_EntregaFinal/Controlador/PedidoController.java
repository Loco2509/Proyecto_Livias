package com.elrinconlivias.Restaurante_EntregaFinal.Controlador;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Cliente;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.DetallePedido;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Pedido;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IClienteService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IPedidoService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("administrador/pedidos")
public class PedidoController {
private final Logger LOGGER = LoggerFactory.getLogger(ProductoController.class);
	
	@Autowired
	@Qualifier("pedido")
	IPedidoService pedidoService;
	
	@Autowired
	IClienteService clienteService;
	
	@GetMapping("/listar")
	public String listar(Model model) {
		List<Pedido> pedidos = pedidoService.findAll();
		model.addAttribute("pedidos",pedidos);
		model.addAttribute("titulo","Lista de los pedidos");
		return "Pedidos/pedidoListar";
	}
	
	@GetMapping("listar/cliente/{id}")
	public String pedidosCliente(@PathVariable("id") Integer id, Model model) {
		Cliente cli = clienteService.findById(id).get();
		List<Pedido> pedidos = pedidoService.findByCliente(cli);
		model.addAttribute("pedidos", pedidos);
		model.addAttribute("titulo", "Pedidos del cliente "+cli.getNombre()+":");
		return "Administrador/Clientes/clientePedidos";
	}
	
	@RequestMapping("listar/cliente/{idCli}/detalles/{idPe}")
	public String detalles (@PathVariable("idCli") Integer idCli,@PathVariable("idPe") Integer idPe, Model model) {
		Cliente cli = clienteService.findById(idCli).get();
		List<DetallePedido> detalles = new ArrayList<DetallePedido>();
		Optional<Pedido> optionalPedido = pedidoService.findById(idPe);
		detalles = optionalPedido.get().getDetalles();
		LOGGER.info("Detalles del pedido buscado: {}", detalles);
		model.addAttribute("detalles", detalles);
		model.addAttribute("cliente", cli);
		return "Administrador/Clientes/clienteDetalles";
	}
	
	
	
	@RequestMapping("/form")
	public String formulario (Model model) {
		//Plato plato = new Plato();
		//model.put("plato",plato);
		model.addAttribute("btn", "Guardar Pedido");
		return "Pedidos/pedidoInsertar";
	}
	
	@RequestMapping("/form/{id}")
	public String actualizar (@PathVariable("id") Integer id,Model model) {
		Pedido pedido = new Pedido();
		Optional<Pedido> optionalPedido = pedidoService.findById(id);
		pedido = optionalPedido.get();
		LOGGER.info("Pedido buscado: {}", pedido);
		model.addAttribute("pedido", pedido);
		model.addAttribute("btn","Actualiza Registro");
		return "Pedidos/pedidoEditar";
	}
	
	@PostMapping("/insertar")
    public String guardar(Pedido pedido){
        // Guardar el objeto Plato
        pedidoService.save(pedido);

        return "redirect:/pedidos/listar";
    }
	
	@PostMapping("/actualizar")
	public String actualizar(Pedido pedido, @RequestParam String estado){
		pedido.setEstado(estado);
		pedidoService.save(pedido);
		return "redirect:/pedidos/listar";
	}
}
