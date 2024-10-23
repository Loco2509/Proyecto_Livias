package com.elrinconlivias.Restaurante_EntregaFinal.Controlador;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Carrito;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Cliente;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.DetallePedido;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Empleado;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Pedido;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Producto;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Rol;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IDetallePedidoService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IEmpleadoService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IMenuDiaService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IPedidoService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IProductoService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IRolService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.ICarritoService;
import com.elrinconlivias.Restaurante_EntregaFinal.Servicios.IClienteService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/inicio")
public class InicioController {
	
	
	
	private final Logger log = LoggerFactory.getLogger(InicioController.class);
	
	@Autowired
	IProductoService productoService;
	
	@Autowired
	IPedidoService pedidoService;
	
	@Autowired
	IDetallePedidoService detallePedidoService;
	
	@Autowired
	IClienteService clienteService;
	
	@Autowired
	IEmpleadoService empleadoService;
	
	@Autowired
	IRolService rolService;
	
	@Autowired
	IMenuDiaService menuDiaService;
	
	@Autowired
	ICarritoService carritoService;
	
	@GetMapping
	public String Home(Model model, HttpSession session) {
		log.info("Sesion del usuario: {}", session.getAttribute("idCliente"));
		List<Producto> allPlatos = productoService.findByActivo(true);
        List<Producto> limitedPlatos = allPlatos.stream()
                                             .limit(10) // Limita a los primeros 10 elementos
                                             .collect(Collectors.toList());

        model.addAttribute("productos", limitedPlatos);
		model.addAttribute("sesion", session.getAttribute("idCliente"));
		return "Cliente/index";
	}
	
	@GetMapping("menu/{dia}")
	public String menu(@PathVariable("dia") String dia, Model model, HttpSession session) {
		log.info("Sesion del usuario: {}", session.getAttribute("idCliente"));
		model.addAttribute("menuDia",menuDiaService.findByDiaNombre(dia));
		model.addAttribute("sesion", session.getAttribute("idCliente"));
		model.addAttribute("carrito", session.getAttribute("carrito"));
		List<Carrito> car = (List<Carrito>) session.getAttribute("carrito");
		if(car!=null) {
			int cantidad = car.stream()
	                .mapToInt(item -> item.getCantidad())  // Obtenemos la cantidad de cada item
	                .sum();  // Sumamos las cantidades
			model.addAttribute("cantidad", cantidad);
		}
		model.addAttribute("total", session.getAttribute("total"));
		return "Cliente/menu";
	}
	
	@GetMapping("pedidos")
	public String listar(Model model, HttpSession session) {
		
		Cliente cliente =clienteService.findById( Integer.parseInt(session.getAttribute("idCliente").toString())).get();
		List<Pedido> pedidos = pedidoService.findByCliente(cliente);
		
		model.addAttribute("pedidos",pedidos);
		model.addAttribute("titulo","Lista de los pedidos");
		return "Cliente/pedidos";
	}
	
	@RequestMapping("detalles/{id}")
	public String detalles (@PathVariable("id") Integer id,Model model) {
		List<DetallePedido> detalles = new ArrayList<DetallePedido>();
		Optional<Pedido> optionalPedido = pedidoService.findById(id);
		detalles = optionalPedido.get().getDetalles();
		log.info("Detalles del pedido buscado: {}", detalles);
		model.addAttribute("detalles", detalles);
		return "Cliente/detallePedidos";
	}
	
	@GetMapping("resumenPedido")
	public String detalles(HttpSession session, Model model) {
		List<DetallePedido> detalles = new ArrayList<>();
		
		List<Carrito> car = (List<Carrito>) session.getAttribute("carrito");
		for (Carrito carrito : car) {
			DetallePedido detalleOrden = new DetallePedido();
            Optional<Producto> optionalProducto = productoService.findById(carrito.getProducto().getIdProducto());
            if (optionalProducto.isPresent()) {
            	Producto plato = optionalProducto.get();
                detalleOrden.setCantidad(carrito.getCantidad());
                detalleOrden.setPrecioUnitario(plato.getPrecio());
                detalleOrden.setNombreProducto(plato.getNombre());
                BigDecimal integerAsBigDecimal = new BigDecimal(carrito.getCantidad());
                detalleOrden.setSubTotal(plato.getPrecio().multiply(integerAsBigDecimal));
                detalleOrden.setProducto(plato);
                detalles.add(detalleOrden);
            } else {
                // Manejar el caso en que el plato no se encuentra
            }
		}
		BigDecimal sumaTotal = detalles.stream()
	            .map(dt -> dt.getSubTotal())  // Asegúrate de que getSubTotal() devuelva BigDecimal
	            .reduce(BigDecimal.ZERO, BigDecimal::add);
		session.setAttribute("resumen", detalles);
        model.addAttribute("resumen", detalles);
        model.addAttribute("total",sumaTotal);
		
		return "Cliente/metodoPago";
	}
	
	
	/*
	@CrossOrigin(origins = "*", methods = {RequestMethod.POST, RequestMethod.GET})
	@RequestMapping("/carrito")
	public String addCarrito(@RequestBody Map<String, Object> data, Model model) {
		
		// Obtener los datos enviados en el JSON
	    List<Integer> ids = (List<Integer>) data.get("listId");
	    List<Integer> cantidades = (List<Integer>) data.get("listCantidad");
        
        Map<Integer, Integer> map = new HashMap<>();
        for (int i = 0; i < ids.size(); i++) {
            map.put(ids.get(i), cantidades.get(i));
        }
        
     // Recorrer el mapa usando keySet()
        for (Integer codigo : map.keySet()) {
            Integer cant = map.get(codigo);
            DetallePedido detalleOrden = new DetallePedido();
    		Plato plato = new Plato();
    		double sumaTotal = 0;
    		Optional<Plato> optionalProducto = platoService.findById(codigo);
    		log.info("Producto añadido: {}", optionalProducto.get());
    		log.info("Cantidad: {}", cant);
    		plato = optionalProducto.get();
    		detalleOrden.setCantidad(cant);
    		detalleOrden.setPrecioUnitario(plato.getPrecio());
    		detalleOrden.setNombre(plato.getNombre());
    		// Convertir el Integer a BigDecimal
            BigDecimal integerAsBigDecimal = new BigDecimal(cant);
    		detalleOrden.setSubTotal(plato.getPrecio().multiply(integerAsBigDecimal));
    		detalleOrden.setPlato(plato);
    		detalles.add(detalleOrden);
        }
        model.addAttribute("carrito", detalles);
		return "Cliente/metodoPago";
	}
	*/
	
	@PostMapping("guardarPedido")
	public String pagar(HttpSession session) {
		List<DetallePedido> detalles = (List<DetallePedido>) session.getAttribute("resumen");
		Pedido pedido = new Pedido();
		Cliente cliente =clienteService.findById( Integer.parseInt(session.getAttribute("idCliente").toString())).get();
		pedido.setCliente(cliente);
		// Calcular la suma total usando BigDecimal
        BigDecimal sumaTotal = detalles.stream()
                .map(DetallePedido::getSubTotal) // Asumimos que getSubTotal devuelve BigDecimal
                .reduce(BigDecimal.ZERO, BigDecimal::add); // Sumar todos los valores BigDecimal
        pedido.setTotal(sumaTotal);
        pedido.setTipo("Online");

        pedido.setEstado("Pendiente");
     // Obtener la fecha y hora actuales
        Timestamp fechaCreacion = new Timestamp(System.currentTimeMillis());
        pedido.setFechaCreacion(fechaCreacion);
		pedidoService.save(pedido);
		
		
		for (DetallePedido dt : detalles) {
			dt.setPedido(pedido);
			dt.setEstado(false);
			detallePedidoService.save(dt);
		}
		carritoService.deleteByCliente(clienteService.findById( Integer.parseInt(session.getAttribute("idCliente").toString())).get());
		session.removeAttribute("carrito");
		session.removeAttribute("total");
		session.removeAttribute("cantidad");
		
		return "redirect:/inicio";
	}
	
	@PostMapping("cancelarPedido/{id}")
	public String cancelar(@PathVariable("id") Integer id) {
		Pedido ped = pedidoService.findById(id).get();
		if("Pendiente".equals(ped.getEstado())) {
			ped.setEstado("Cancelado");
			pedidoService.save(ped);
		}else {
			
		}
		return "redirect:/inicio/pedidos";
	}
	
	@GetMapping("loginForm")
	public String form(Model modelo) {
		modelo.addAttribute("usuario",new Cliente());
		return "Cliente/login";
	}
	
	@PostMapping("registrar")
	public String registrar(Cliente cliente, HttpSession session) {
		Date fechaCreacion = new Date();
		cliente.setFechaCreacion(fechaCreacion);
		clienteService.save(cliente);
		session.setAttribute("idCliente", cliente.getIdCliente());
		return "redirect:/inicio";
	}
	
	@PostMapping("login")
	public String login(@RequestParam String emailLog, @RequestParam String claveLog,HttpSession session,  Model modelo) {
		if(!emailLog.isEmpty() && !claveLog.isEmpty()) {
			Optional<Cliente> cliente = clienteService.findByEmail(emailLog);
			Optional<Empleado> empleado = empleadoService.findByEmail(emailLog);
			
			if (empleado.isPresent() && empleado.get().isActivo()) {
				if(empleado.get().getClave().equals(claveLog)) {
					session.setAttribute("idEmpleado", empleado.get().getIdEmpleado());
					List<Rol> roles = rolService.findByEmpleado(empleado.get());
					for(Rol rol: roles) {
						if("Administrador".equals(rol.getRolNombre())) {
							return "redirect:/administrador/productos/listar/activos";
						}
					}
					for(Rol rol: roles) {
						if("Camarero".equals(rol.getRolNombre())){
							return "redirect:/carrito/listar";
						}else if("Cocinero".equals(rol.getRolNombre())) {
							return "redirect:/puestos/cocinero/pedidos/Pendiente";
						}else {
							return "redirect:/inicio";
						}
					}
				}else {
					return "redirect:/inicio";
				}
			} else if(cliente.isPresent()){
				if(cliente.get().getClave().equals(claveLog)) {
					session.setAttribute("idCliente", cliente.get().getIdCliente());
				}
				return "redirect:/inicio";
			}else {
				log.info("Usuario no existe");
			}
		}
		return "redirect:/inicio";
	}
	
	@PostMapping("cerrar")
	public String cerrarSesion(HttpSession session) {
		carritoService.deleteByCliente(clienteService.findById( Integer.parseInt(session.getAttribute("idCliente").toString())).get());
		session.removeAttribute("carrito");
		session.removeAttribute("total");
		session.removeAttribute("cantidad");
		session.removeAttribute("idCliente");
		return "redirect:/inicio";
	}
}
