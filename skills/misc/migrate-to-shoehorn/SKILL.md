---
name: migrate-to-shoehorn
description: Migra arquivos de teste de assertions de tipo `as` para @total-typescript/shoehorn. Use quando o usuário mencionar shoehorn, quiser substituir `as` em testes ou precisar de dados de teste parciais.
---

# Migrate to Shoehorn

## Por que shoehorn?

`shoehorn` deixa você passar dados parciais em testes mantendo o TypeScript feliz. Ele substitui assertions com `as` por alternativas type-safe.

**Apenas em código de teste.** Nunca use shoehorn em código de produção.

Problemas com `as` em testes:

- Treinado a não usar
- Precisa especificar manualmente o tipo alvo
- Double-as (`as unknown as Type`) para dados intencionalmente errados

## Instalar

```bash
npm i @total-typescript/shoehorn
```

## Padrões de migração

### Objetos grandes com poucas propriedades necessárias

Antes:

```ts
type Request = {
  body: { id: string };
  headers: Record<string, string>;
  cookies: Record<string, string>;
  // ...20 more properties
};

it("gets user by id", () => {
  // Only care about body.id but must fake entire Request
  getUser({
    body: { id: "123" },
    headers: {},
    cookies: {},
    // ...fake all 20 properties
  });
});
```

Depois:

```ts
import { fromPartial } from "@total-typescript/shoehorn";

it("gets user by id", () => {
  getUser(
    fromPartial({
      body: { id: "123" },
    }),
  );
});
```

### `as Type` → `fromPartial()`

Antes:

```ts
getUser({ body: { id: "123" } } as Request);
```

Depois:

```ts
import { fromPartial } from "@total-typescript/shoehorn";

getUser(fromPartial({ body: { id: "123" } }));
```

### `as unknown as Type` → `fromAny()`

Antes:

```ts
getUser({ body: { id: 123 } } as unknown as Request); // wrong type on purpose
```

Depois:

```ts
import { fromAny } from "@total-typescript/shoehorn";

getUser(fromAny({ body: { id: 123 } }));
```

## Quando usar cada um

| Função          | Caso de uso                                                  |
| --------------- | ------------------------------------------------------------ |
| `fromPartial()` | Passar dados parciais que ainda satisfazem o type check      |
| `fromAny()`     | Passar dados intencionalmente errados (mantém autocomplete)  |
| `fromExact()`   | Forçar objeto completo (trocar por fromPartial mais tarde)   |

## Fluxo de trabalho

1. **Levante requisitos** - pergunte ao usuário:
   - Quais arquivos de teste têm assertions com `as` causando problemas?
   - Eles estão lidando com objetos grandes onde só algumas propriedades importam?
   - Eles precisam passar dados intencionalmente errados para teste de erros?

2. **Instale e migre**:
   - [ ] Instalar: `npm i @total-typescript/shoehorn`
   - [ ] Encontrar arquivos de teste com assertions `as`: `grep -r " as [A-Z]" --include="*.test.ts" --include="*.spec.ts"`
   - [ ] Substituir `as Type` por `fromPartial()`
   - [ ] Substituir `as unknown as Type` por `fromAny()`
   - [ ] Adicionar imports de `@total-typescript/shoehorn`
   - [ ] Rodar type check para verificar
