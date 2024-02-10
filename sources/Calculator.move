// Copyright (c) 2022, Sui Foundation
// SPDX-License-Identifier: Apache-2.0

module calculator::calculator {
    use sui::object::{Self, UID};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    struct Numbers has key {
	id: UID,
        a: u64,
        b: u64,
	}

    struct Result has key {
        id: UID,
        answer: u64
    }

    public entry fun new(num_1: u64, num_2: u64, ctx: &mut TxContext) {
        let numbers = Numbers {
            id: object::new(ctx),
            a: num_1,
            b: num_2,
        };
        transfer::transfer(numbers, tx_context::sender(ctx));
    }

    public entry fun add(n: &Numbers, ctx: &mut TxContext) {
        let result = Result {
            id: object::new(ctx),
            answer: n.a + n.b
        };
        transfer::transfer(result, tx_context::sender(ctx));
    }

    public entry fun sub(n: &Numbers, ctx: &mut TxContext) {
        let result = Result {
            id: object::new(ctx),
            answer: n.a - n.b
        };
        transfer::transfer(result, tx_context::sender(ctx));
    }

    public entry fun mul(n: &Numbers, ctx: &mut TxContext) {
        let result = Result {
            id: object::new(ctx),
            answer: n.a * n.b
        };
        transfer::transfer(result, tx_context::sender(ctx));
    }

    public entry fun div(n: &Numbers, ctx: &mut TxContext) {
        assert!(n.b != 0, 0);
        let result = Result {
            id: object::new(ctx),
            answer: n.a / n.b
        };
        transfer::transfer(result, tx_context::sender(ctx));
    }
}
