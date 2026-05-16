# Testes Bons e Ruins

## Testes Bons

**Integration-style**: Testam por interfaces reais, não por mocks de partes internas.

```typescript
// BOM: Testa comportamento observável
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

Características:

- Testam comportamento que usuários/chamadores se importam
- Usam apenas a API pública
- Sobrevivem a refactors internos
- Descrevem O QUÊ, não COMO
- Uma asserção lógica por teste

## Testes Ruins

**Testes de detalhe de implementação**: Acoplados a estrutura interna.

```typescript
// RUIM: Testa detalhes de implementação
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

Sinais de alerta:

- Mockar colaboradores internos
- Testar métodos privados
- Assertar sobre contagens/ordens de chamada
- Teste quebra ao refatorar sem mudança de comportamento
- Nome do teste descreve COMO em vez de O QUÊ
- Verificar por meios externos em vez de pela interface

```typescript
// RUIM: Contorna a interface para verificar
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// BOM: Verifica pela interface
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```
