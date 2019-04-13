'use strict';

function findIndex(o, condition) {
  return o.indexOf(find(o, condition));
}


function dropWhile(o, condition) {
  var result = [];
  map(o, (v, k) => {
    if (!condition(v, k)) {
      result.push(v);
    }
  });
  return result;
}


function filter(o, condition) {
  var result = [];
  forEach(o, (v, k) => {
    if (condition(v, k)) {
      result.push(v);
    }
  });
  return result;
}


function map(o, fn) {
  if (o instanceof Array) {
    return Array.prototype.map.call(o, fn);
  } else {
    var result = [];
    forEach(o, (v, k) => {
      result.push(fn(v, k));
    });
    return result;
  }
}


/*
 forEach({a: 1, b: 2}, (v, k) => {
 console.log({
 v, k
 })
 })

 forEach([1,2,3],(v,k)=>{
 console.log({
 v,k
 })
 })
 */

function forEach(o, fn) {
  if (o instanceof Array) {
    return Array.prototype.forEach.call(o, fn);
  }
  Object.keys(o).forEach((key) => {
    fn(o[key], key);
  });
}


/* console.log(
 find([{name: 1}, {name: 2}], (o) => {
 return o.name === 2;
 }))

 console.log(find([{name: 1,age:2}, {name: 2}], {name:1}))
 */
function find(o, condition) {
  var result = null;
  forEach(o, (v, k) => {
    if (typeof condition === 'function') {
      if (condition(v, k)) {
        result = v;
      }
    } else {
      var propName = Object.keys(condition)[0];
      if (propName && v[propName] === condition[propName]) {
        result = v;
      }
    }
  });
  return result;
}


module.exports = {
  find,
  forEach,
  map,
  filter,
  dropWhile,
  findIndex
};
