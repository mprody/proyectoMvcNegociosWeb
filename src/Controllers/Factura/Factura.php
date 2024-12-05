<?php
namespace Controllers\Factura;

use Controllers\PrivateController;
use Controllers\PublicController;
use Dao\Factura\FacturaModel;
use Dao\Factura\DetalleVentaModel;
use Views\Renderer;

class Factura extends PrivateController
{
    public function run(): void
    {
        $codFactura = isset($_GET['codFactura']) ? $_GET['codFactura'] : null;
        $facturaDao = FacturaModel::obtenerFacturaPorCodigo($codFactura);
        $detalleDao = DetalleVentaModel::obtenerDetallesPorFactura($codFactura);
        $clienteDao = FacturaModel::obtenerNombreCliente($codFactura);

        $porcentajeImpuesto = $facturaDao['impuestoFactura'] / 100;

            $totalFactura = 0;
            $subtotal = 0;
            $impuesto = 0;


        $viewfactura = $facturaDao;
        $viewCliente = $clienteDao;

        $viewdetalle = [];
        foreach($detalleDao as $detalle) {
            $detalle['totalLinea'] = $detalle['precioVenta'] * $detalle['Cantidad'];
            $totalFactura += $detalle['totalLinea'];
            $viewdetalle[] = $detalle;
        }

         $impuesto = $totalFactura * $porcentajeImpuesto;
         $subtotal = $totalFactura - $impuesto;

        $viewData['factura'] = $viewfactura;
        $viewData['detalle'] = $viewdetalle;
        $viewData['subtotalFactura'] = $subtotal;
        $viewData['impuestoFactura'] = $impuesto;
        $viewData['totalFactura'] = $totalFactura;
        $viewData['username'] = $viewCliente;

        Renderer::render('factura/factura_list', $viewData);
    }
}
