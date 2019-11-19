$(document).ready(function() {
    
    $(".add_colorAndSize").on("click", function() {
        var html = '<div class="area_colorAndSize">'
                 + '    <input type="text" class="product_color" placeholder="색상 입력 (ex 화이트)">&nbsp;'
                 + '    <input type="button" value="사이즈 추가" onclick="addSizeForColor(this)">&nbsp;'
                 + '    <input type="button" value="X" onclick="deletePrtDiv(this)"><br><br>'
                 + '</div>';
        
        $(".detailInfo").append(html);
    }); // end add_colorAndSize

    $(".add_color").on("click", function() {
        var html = '<div class="area_color">'
                 + '    <input type="text" class="product_color" placeholder="색상 입력 (ex 화이트)">&nbsp;'
                 + '    <input type="text" class="product_stock" placeholder="재고 입력"> 개&nbsp;'
                 + '    <input type="button" value="X" onclick="deletePrtDiv(this)">'
                 + '</div>';

        $(".detailInfo").append(html);
    }); // end add_color

    $(".add_size").on("click", function() {
        var html = '<div class="area_size">'
                 + '    <select class="product_size">'
                 + '        <option value="XS">XS</option>'
                 + '        <option value="S">S</option>'
                 + '        <option value="M">M</option>'
                 + '        <option value="L">L</option>'
                 + '    <option value="XL">XL</option>'
                 + '    </select>'
                 + '    <input type="text" class="product_stock" placeholder="재고 입력"> 개&nbsp;'
                 + '    <input type="button" value="X" onclick="deletePrtDiv(this)">'
                 + '</div>';
        
        $(".detailInfo").append(html);
    }); // end add_size

}); // end document

// 색상&사이즈에서 사이즈 추가
function addSizeForColor(add_btn) {
    var html = '<div class="area_size_in_color">'
             + '    <select class="product_size">'
             + '        <option value="XS">XS</option>'
             + '        <option value="S">S</option>'
             + '        <option value="M">M</option>'
             + '        <option value="L">L</option>'
             + '    <option value="XL">XL</option>'
             + '    </select>'
             + '    <input type="text" class="product_stock" placeholder="재고 입력"> 개&nbsp;'
             + '    <input type="button" class="delete_size" value="X" onclick="deletePrtDiv(this)">'
             + '</div>';

    $(add_btn).parent().append(html);
}

// 부모 div를 제거
function deletePrtDiv(delete_btn) {
    $(delete_btn).parent().remove();
}

function detailInfo() {
    var product_detail = null;
    
    var color_arr = [];
    var size_arr = [];
    var stock_arr = [];

    if($(".product_color").val() && $(".product_size").val()) { // 색상&사이즈
        $(".product_stock").each(function() {
            console.log($(this).parent().prevAll(".product_color").val());
            console.log($(this).prev().val());
            console.log(this.value);
    
            color = $(this).parent().prevAll(".product_color").val();
            size = $(this).next().val();
            stock = this.value;
    
            color_arr.push(color);
            size_arr.push(size);
            stock_arr.push(stock);
        }); // end each

        for(var i = 0; i < stock_arr.length; i++) {
            product_detail = {
                product_color : color_arr[i],
                product_size : size_arr[i],
                product_stock : stock_arr[i]
            };

            sendPro(product_detail);
        } // end for

    } else if($(".product_color").val() && !$(".product_size").val()) { // 색상
        $(".product_stock").each(function() {
            console.log($(this).prev().val());
            console.log(this.value);

            color = $(this).prev().val();
            stock = this.value;

            color_arr.push(color);
            stock_arr.push(stock);
        }); // end each

        for(var i = 0; i < stock_arr.length; i++) {
            product_detail = {
                product_color : color_arr[i],
                product_stock : stock_arr[i]
            };

            sendPro(product_detail);
        } // end for
        
    } else if(!$(".product_color").val() && $(".product_size").val()) { // 사이즈
        $(".product_stock").each(function() {
            console.log($(this).prev().val());
            console.log(this.value);

            size = $(this).prev().val();
            stock = this.value;

            size_arr.push(size);
            stock_arr.push(stock);
        }); // end each

        for(var i = 0; i < stock_arr.length; i++) {
            product_detail = {
                product_size : size_arr[i],
                product_stock : stock_arr[i]
            };

            sendPro(product_detail);
        } // end for

    } // end if
    
} // end detailInfo()

function sendPro(productDetail) {
    $.ajax({
        type : "post",
        url : "/admin/productInfo",
        data : JSON.stringify(productDetail),
        async : false,
        contentType : "application/json; charset=utf-8"
    });
} // sendPro

function regist() {
    
	// product detail 먼저 전달해서 List에 담아둔다
    detailInfo();
    // product 정보를 등록한다
    $("#registForm").submit();
}

function highCategory(e){
    var outer = ["자켓","수트","코트","점퍼/짚업"];
    var top = ["긴팔","가디건","니트","반팔","조끼"];
    var shirts = ["베이직","체크/패턴","스트라이프"];
    var bottom = ["슬랙스","데님","면바지","반바지"];
    var bag = ["가방"];
    var shoes = ["신발"];
    var acc = ["악세사리"];

    var target = document.getElementById("lowCategory");
    
    if (e.value == "1") var d = outer;
    else if (e.value == "2") var d = top;
    else if (e.value == "3") var d = shirts;
    else if (e.value == "4") var d = bottom;
    else if (e.value == "5") var d = bag;
    else if (e.value == "6") var d = shoes;
    else if (e.value == "7") var d = acc;
    
    target.options.length = 0;
    
    for(x in d){
        var opt = document.createElement("option");
        opt.value = e.value + x;	
        opt.innerHTML = d[x];
        target.appendChild(opt);
    }
}

