# Candidatos a Refactor

Depois de um ciclo de TDD, procure por:

- **Duplicação** → Extraia função/classe
- **Métodos longos** → Quebre em helpers privados (mantenha testes na interface pública)
- **Módulos rasos** → Combine ou aprofunde
- **Feature envy** → Mova a lógica para onde os dados vivem
- **Obsessão por primitivos** → Introduza value objects
- **Código existente** que o código novo revela como problemático
