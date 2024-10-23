package com.elrinconlivias.Restaurante_EntregaFinal.Servicios;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Comprobante;
import com.elrinconlivias.Restaurante_EntregaFinal.Modelo.Pago;
import com.elrinconlivias.Restaurante_EntregaFinal.Repositorios.IComprobante;

@Service("comprobante")
public class SComprobanteImpl implements IComprobanteService{
	
	@Autowired
	IComprobante iComprobanteRepository;

	@Override
	public Optional<Comprobante> findFirstByTipoOrderByIdComprobanteDesc(String tipo) {
		return iComprobanteRepository.findFirstByTipoOrderByIdComprobanteDesc(tipo);
	}

	@Override
	public Optional<Comprobante> findByPago(Pago pago) {
		return iComprobanteRepository.findByPago(pago);
	}

	@Override
	public List<Comprobante> findByTipo(String tipo) {
		return iComprobanteRepository.findByTipo(tipo);
	}

	@Override
	public Optional<Comprobante> findByNumero(String numero) {
		return iComprobanteRepository.findByNumero(numero);
	}

	@Override
	public List<Comprobante> findAll() {
		return iComprobanteRepository.findAll();
	}

	@Override
	public Optional<Comprobante> findById(Integer id) {
		return iComprobanteRepository.findById(id);
	}

	@Override
	public Comprobante save(Comprobante comprobante) {
		Optional<Comprobante> ultimoComprobante = findFirstByTipoOrderByIdComprobanteDesc(comprobante.getTipo());
		String numero = generarNumeroComprobante(ultimoComprobante.get());
		comprobante.setNumero(numero);
		return iComprobanteRepository.save(comprobante);
	}

	@Override
	public String generarNumeroComprobante(Comprobante ultimoComprobante) {
		String serie = "";
		int numero = 1;
		if("Boleta".equals(ultimoComprobante.getTipo())) {
			serie = "B001";
		}else if("Factura".equals(ultimoComprobante.getTipo())) {
			serie = "F001";
		}
		
		if(ultimoComprobante != null) {
			// Extraer el número actual y sumarle 1
			String[] partes = ultimoComprobante.getNumero().split("-");
			numero = Integer.parseInt(partes[1])+1;
		}
		
		// Formatear el número con ceros a la izquierda (por ejemplo, 000001), todo el string mide 6 digitos
		String numeroFormateado = String.format("%06d", numero);
		
		// Retornar el número completo de serie (ejemplo: F001-000002)
		return serie+"-"+numeroFormateado;
	}

}
