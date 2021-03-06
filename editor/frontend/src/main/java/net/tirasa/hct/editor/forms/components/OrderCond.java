/*
 * Copyright (C) 2012 Tirasa
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package net.tirasa.hct.editor.forms.components;

/**
 * Search condition to be applied when comparing attribute values.
 */
public class OrderCond {

    public enum Type {

        ASCENDING,
        DESCENDING

    }

    private Type type;

    private String schema;

    private String expression;

    public OrderCond() {
        super();
    }

    public OrderCond(final Type conditionType) {
        super();
        this.type = conditionType;
    }

    public final String getExpression() {
        return expression;
    }

    public final void setExpression(final String conditionExpression) {
        this.expression = conditionExpression;
    }

    public final String getSchema() {
        return schema;
    }

    public final void setSchema(final String conditionSchema) {
        this.schema = conditionSchema;
    }

    public final Type getType() {
        return type;
    }

    public final void setType(final Type conditionType) {
        this.type = conditionType;
    }
}
