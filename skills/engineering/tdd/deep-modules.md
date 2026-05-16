# Deep Modules

De "A Philosophy of Software Design":

**Módulo profundo** = interface pequena + bastante implementação

```
┌─────────────────────┐
│   Small Interface   │  ← Poucos métodos, params simples
├─────────────────────┤
│                     │
│                     │
│  Deep Implementation│  ← Lógica complexa escondida
│                     │
│                     │
└─────────────────────┘
```

**Módulo raso** = interface grande + pouca implementação (evite)

```
┌─────────────────────────────────┐
│       Large Interface           │  ← Muitos métodos, params complexos
├─────────────────────────────────┤
│  Thin Implementation            │  ← Só repassa
└─────────────────────────────────┘
```

Ao desenhar interfaces, pergunte:

- Posso reduzir o número de métodos?
- Posso simplificar os parâmetros?
- Posso esconder mais complexidade dentro?
