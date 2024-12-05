<style>
.align-right-container {
  display: flex !important;
  flex-direction: column !important; 
  align-items: flex-end !important; 
  width: 30% !important;  
}

.align-right-row {
  display: flex !important;  
  justify-content: space-between !important; 
  align-items: center !important; 
  width: 100% !important;  
  margin-bottom: 10px !important; 
}

.align-right-row label {
  text-align: left !important; 
  flex-basis: 50% !important; 
}

.align-right-row p {
  text-align: right !important; 
  flex-basis: 50% !important; 
}

/* CSS DE LAS TABLAS */

.table th, .table td {
  text-align: center;
  vertical-align: middle; 
  border: 1px solid #000; 
}


.table {
  border: 1px solid #c8c8c8;
  border-collapse: collapse; 
}

h3.text-center {
  text-align: center;
}

/*Estilos personalizados para la imagen de logo */


.custom-container {
  display: flex;
  justify-content: space-between; 
  align-items: center; 
}

.custom-logo {
  padding: 10px;
}

.section-content {
  display: flex; 
  justify-content: flex-start; 
  align-items: center; 
}

.logo {
  width: 120px; 
  height: auto; 
  margin-left: 500px; 
}


</style>

 <div class="print-button-container no-print">
    <button id="printButton">
      <i class="fas fa-print"></i> <!-- Ícono de impresora -->
      Imprimir
    </button>
  </div>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Factura</title>
   <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    /* Estilos para el contenedor del botón */
    .print-button-container {
      display: flex;
      justify-content: flex-end;
      margin: 10px 0;
    }

    /* Estilos para el botón */
    #printButton {
      background-color: #007BFF; /* Azul claro */
      color: #fff; /* Texto blanco */
      border: none;
      border-radius: 5px;
      padding: 10px 15px;
      font-size: 16px;
      cursor: pointer;
      display: flex;
      align-items: center;
      gap: 8px; /* Espacio entre ícono y texto */
      transition: background-color 0.3s ease;
    }

    #printButton:hover {
      background-color: #0056b3; /* Azul más oscuro */
    }

    #printButton i {
      font-size: 20px; /* Tamaño del ícono */
    }

    /* Clase para ocultar elementos en la impresión */
    @media print {
      .no-print {
        display: none;
      }
    }
  </style>
</head>
<body>
  <section class="container-m row px-4 py-4">
    <div class="section-content">
      <h1>FACTURA</h1>
      <img src="https://cfsumar.com/imagenes/sumarlogo.jpg" alt="Logo de la empresa" class="logo">
    </div>
  </section>

  <section class="container-m row px-4 py-4">
    <h1>Ferretería Sumar</h1>
  </section>

  <section class="container-m row px-4 py-4">
    {{with factura}}
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="codigoFactura">ID FACTURA:</label>
      <p class="col-12 col-m-9" id="codigoFactura">{{codFactura}}</p>
    </div>
    <div class="row my-2 align-center">
      <label class="col-12 col-m-3" for="fechaFactura">FECHA DE EMISIÓN:</label>
      <p class="col-12 col-m-9" id="fechaFactura">{{fechaFactura}}</p>
    </div>
    {{endwith factura}}
  </section>

  <h3 class="text-center">Detalles</h3>
  <section class="WWList">
    <table class="table">
      <thead>
        <tr>
          <th>Código Producto</th>
          <th>Producto</th>
          <th>Precio Unitario</th>
          <th>Cantidad</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        {{foreach detalle}}
        <tr>
          <td>{{CodigoProductos}}</td>
          <td>{{Producto}}</td>
          <td>L. {{precioVenta}}</td>
          <td>{{Cantidad}}</td>
          <td>L. {{totalLinea}}</td>
        </tr>
        {{endfor detalle}}
      </tbody>
    </table>
  </section>

  <section class="align-right-container row px-4 py-4" style="margin-left: auto; margin-right: 0;">
    <div class="align-right-row my-2">
      {{with factura}}
      <label for="impuesto {{impuestoFactura}}">IMPUESTO:</label>
      {{endwith factura}}
      <p id="impuesto">L. {{impuestoFactura}}</p>
    </div>
    <div class="align-right-row my-2">
      <label for="subtotal">SUBTOTAL:</label>
      <p id="subtotal">L. {{subtotalFactura}}</p>
    </div>
    <div class="align-right-row my-2">
      <label for="total">TOTAL:</label>
      <p id="total">L. {{totalFactura}}</p>
    </div>
  </section>

  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const printButton = document.getElementById('printButton');
      printButton.addEventListener('click', function () {
        window.print();
      });
    });
  </script>
</body>
</html>
