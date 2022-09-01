Challenge #3

We have a nested object, we would like a function that you pass in the object and a key and get back the value. How this is implemented is up to you.
Example Inputs
object = {“a”:{“b”:{“c”:”d”}}}
key = a/b/c
object = {“x”:{“y”:{“z”:”a”}}}
key = x/y/z
value = a



function result(obj, key) {
    var value = JSON.parse(obj);
    var keys = key.split("/");
    for (var i=0; i<keys.length; i++){
        value = value[keys[i]];
    }
    return value;
}

var object = "{\"a\":{\"b\":{\"c\":\"val\"}}}";
var key = "a/b/c";
var value = result(object, key);
console.log(value);
