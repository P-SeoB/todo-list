package com.example.backend.domain.card;

import java.util.Arrays;

public enum CardType {
    TODO("todoItems"), COMPLETED("completedItems"), PROGRESSING("progressingItems");

    private final String name;

    CardType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public static CardType findByName(String name){
        return Arrays.stream(values())
                .filter(x->x.getName().equals(name))
                .findAny()
                .orElseThrow();
    }
}
