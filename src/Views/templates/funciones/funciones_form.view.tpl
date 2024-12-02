<h1>{{modes_dsc}}</h1>
<section class="grid">
    <form action="index.php?page=Funciones-FuncionesForm&mode={{mode}}&fncod={{fncod}}" method="post" class="row">
        {{with funcion}}
        <div class="row col-6 offset-3">
            <label class="col-4" for="fncod">Código</label>
            <input class="col-8" type="text" name="fncod" id="fncod" value="{{fncod}}" readonly />
        </div>
        <div class="row col-6 offset-3">
            <label class="col-4" for="fndsc">Descripción</label>
            <input class="col-8" type="text" name="fndsc" id="fndsc" value="{{fndsc}}" {{~readonly}} />
            {{if ~fndsc_haserror}}
                <div class="error">
                    <ul>
                    {{foreach ~fndsc_error}}
                        <li>{{this}}</li>
                    {{endfor ~fndsc_error}}
                    </ul>
                </div>
            {{endif ~fndsc_haserror}}
        </div>
        <div class="row col-6 offset-3">
            <label class="col-4" for="fnest">Estado</label>
            <input class="col-8" type="text" name="fnest" id="fnest" value="{{fnest}}" {{~readonly}} />
             {{if ~fnest_haserror}}
            <div class="error">
                <ul>
                {{foreach ~fnest_error}}
                    <li>{{this}}</li>
                {{endfor ~fnest_error}}
                </ul>
            </div>
        {{endif ~fnest_haserror}}
        </div>
        <div class="row col-6 offset-3">
            <label class="col-4" for="fntyp">Tipo</label>
            <input class="col-8" type="text" name="fntyp" id="fntyp" value="{{fntyp}}" {{~readonly}} />
        </div>        
        
        <div class="row col-6 offset-3 flex-end">
            {{if ~showConfirm}}
                <button type="submit" class="primary">Confirmar</button>&nbsp;
            {{endif ~showConfirm}}
            <button id="btnCancelar" class="btn">Cancelar</button>
        </div>
        {{if ~global_haserror}}
            <div class="error">
                <ul>
                    {{foreach ~global_error}}
                        <li>{{this}}</li>
                    {{endfor ~global_error}}
                </ul>
            </div>
        {{endif ~global_haserror}}
        {{endwith funcion}}
    </form>
</section>
<script>
    document.addEventListener("DOMContentLoaded", ()=>{
        document.getElementById("btnCancelar").addEventListener('click', (e)=>{
            e.preventDefault();
            e.stopPropagation();
            window.location.assign("index.php?page=Funciones-FuncionesList");
        })
    })
</script>