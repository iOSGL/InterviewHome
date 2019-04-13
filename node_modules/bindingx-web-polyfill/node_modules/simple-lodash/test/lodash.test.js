const expect = require('chai').expect;
const _ = require('../lib/index');

describe('Testing', function() {
	it('should findIndex', function() {
		var result = _.findIndex([1,2,3],(o)=>{ return o === 2 });
		expect(result).to.be.equal(1);
	});

	it('should find', function() {
		var result = _.find([1,2,3],(o)=>{ return o === 2 });
		expect(result).to.be.ok;
		expect(result).to.be.equal(2);
	});

	it('should forEach an object',function(){
		_.forEach({a:1,b:2,c:3},(v,k)=>{ 
			expect(v).to.be.ok;
			expect(k).to.be.ok;
		});
	});

	it('should filter an array',function(){
		var result = _.filter([{a:1},{a:2},{a:3}],(v,k)=>{ 
			return v.a >= 2;
		});
		expect(result.length).to.be.equal(2);
	});

	

	

 });