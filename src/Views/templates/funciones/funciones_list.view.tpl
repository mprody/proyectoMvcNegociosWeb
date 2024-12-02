<h1>Listado de Funciones</h1>
<section class="WWList">
    <table>
        <thead>
            <tr>
                <th>Codigo</th>
                <th>Descripción</th>
                <th>Estado O</th>
                <th>Tipo</th>
                <th>Estado</th>               
                <th><a href="index.php?page=Funciones-FuncionesForm&mode=INS"><i class="fas fa-solid fa-plus"></i></a></th>
            </tr>
        </thead>
        <tbody>
            {{foreach funcion}}
                <tr>
                    <td>{{fncod}}</td>
                    <td>{{fndsc}}</td>
                    <td>{{fnest}}</td>                   
                    <td>{{fntyp}}</td>
                    <td>{{estadoDsc}}</td>                  
                    <td style="display:flex; gap:1rem; justify-content:center; align-items:center">
                        <a href="index.php?page=Funciones-FuncionesForm&mode=UPD&fncod={{fncod}}">
                            <i class="fas fa-edit"></i>
                        </a>
                        <a href="index.php?page=Funciones-FuncionesForm&mode=DEL&fncod={{fncod}}">
                            <i class="fas fa-trash"></i>
                        </a>
                        <a href="index.php?page=Funciones-FuncionesForm&mode=DSP&fncod={{fncod}}">
                            <i class="fas fa-eye"></i>
                        </a>
                    </td>
                </tr>
            {{endfor funcion}}
        </tbody>
    </table>
</section>