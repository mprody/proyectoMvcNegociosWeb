<?php
namespace Dao\Products;

use Dao\Table;

class  ProductsD extends Table{
    //metodos para cargar informacion a las cards
    public static function getFeaturedProducts() {
        $sqlstr="select p.productId,p.productName,p.productDescription,p.productPrice,p.productImgUrl,p.productStatus from products p inner join highlights h on p.productId= h.productId";
        $params=[];
        $registros=self::obtenerRegistros($sqlstr,$params);
        return $registros;
    }

    public static function getNewProducts() {
        $sqlstr="select p.productId,p.productName,p.productDescription,p.productPrice,p.productImgUrl, p.productStatus from products p where p.productStatus='ACT' order by p.productId desc limit 3";
        $params=[];
        $registros=self::obtenerRegistros($sqlstr,$params);
        return $registros;
    }

    public static function getDailyDeals() {
      $sqlstr="select p.productId, p.productName, p.productDescription, s.salePrice as productPrice, p.productImgUrl, p.productStatus from products p inner join sales s on p.productId= s.productId";
      $params=[];
      $registros=self::obtenerRegistros($sqlstr,$params);
      return $registros;
    }

    //Codigo para implementar el patron de diseño Work With
    public static function getProducts(
        string $partialName="",
        string $status="",
        string $orderBy="",
        bool $orderDescending=false,
        int $page=0,
        int $itemsPerPage=10
    ){
        $sqlstr = "SELECT p.productId, p.productName, p.productDescription, p.productPrice, p.productImgUrl, p.productStatus, case when p.productStatus = 'ACT' then 'Activo' when p.productStatus = 'INA' then 'Inactivo' else 'Sin Asignar' end as productStatusDsc 
        FROM products p";
        $sqlstrCount = "SELECT COUNT(*) as count FROM products p";
        $conditions = [];
        $params = [];
        if ($partialName != "") {
          $conditions[] = "p.productName LIKE :partialName";
          $params["partialName"] = "%" . $partialName . "%";
        }
        if (!in_array($status, ["ACT", "INA", ""])) {
          throw new \Exception("Error Processing Request Status has invalid value");
        }
        if ($status != "") {
          $conditions[] = "p.productStatus = :status";
          $params["status"] = $status;
        }
        if (count($conditions) > 0) {
          $sqlstr .= " WHERE " . implode(" AND ", $conditions);
          $sqlstrCount .= " WHERE " . implode(" AND ", $conditions);
        }
        if (!in_array($orderBy, ["productId", "productName", "productPrice", ""])) {
          throw new \Exception("Error Processing Request OrderBy has invalid value");
        }
        if ($orderBy != "") {
          $sqlstr .= " ORDER BY " . $orderBy;
          if ($orderDescending) {
            $sqlstr .= " DESC";
          }
        }

        $numeroDeRegistros=self::obtenerUnRegistro($sqlstrCount,$params)["count"];
        $pagesCount=ceil($numeroDeRegistros/$itemsPerPage);
        if($page>$pagesCount -1){
            $page=$pagesCount-1;
        }
        $sqlstr .= " limit ".$page* $itemsPerPage . ", " .$itemsPerPage;
        //die($sqlstr);
        $registros=self::obtenerRegistros($sqlstr,$params);
        return ["products"=>$registros,"total"=>$numeroDeRegistros,"page"=>$page,"itemsPerPage"=>$itemsPerPage];
    }

    public static function getProductById(int $productId){
        $sqlstr="select p.productId,p.productName,p.productDescription,p.productPrice,p.productImgUrl,p.productStatus from products p where p.productId=:productId";
        $params=["productId"=>$productId];
        return self::obtenerUnRegistro($sqlstr,$params);
    }

    public static function insertProduct(
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        string $productStatus,
    ){
        $sqlstr="insert into products (productName,productDescription,productPrice,productImgUrl,productStatus values(:productName,:productDescription,:productPrice,:productImgUrl,:productStatus))";
        $params=[
            "productName"=>$productName,
            "productDescription"=>$productDescription,
            "productPrice"=>$productPrice,
            "productImgUrl"=>$productImgUrl,
            "productStatus"=>$productStatus,
        ];

        return self::executeNonQuery($sqlstr,$params);
    }

    public static function updateProduct(
        int $productId,
        string $productName,
        string $productDescription,
        float $productPrice,
        string $productImgUrl,
        string $productStatus,
    ){
        $sqlstr="update products set productName= :productName,productDescription= :productDescription,productPrice= :productPrice, productImgUrl= :productImgUrl,productStatus= :productStatus where productId = :productId";
        $params=[
            "productId"=>$productId,
            "productName"=>$productName,
            "productDescription"=>$productDescription,
            "productPrice"=>$productPrice,
            "productImgUrl"=>$productImgUrl,
            "productStatus"=>$productStatus,
        ];
        return self::executeNonQuery($sqlstr,$params);
    }

    public static function deleteProduct(int $productId){
        $sqlstr="delete from products where productId = :productId";
        $params=["productId"=>$productId];
        return self::executeNonQuery($sqlstr,$params);
    }

}
?>