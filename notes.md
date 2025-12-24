# Note componenti nvim

Appunti per evidenziare le componenti principali di alcuni servizi fondamentali per lo sviluppo in NVIM. Lo scopo è creare un riferimento per verificare le installazioni dei servizi

## LSP

[ Language Server Protocol ]('https://microsoft.github.io/language-server-protocol/'), si compone di tre elementi

- Treesitter, parser per documenti. Richiede installazione parser per ogni linguaggio.
  Fornisce all'LSP client un parser specifico per il linguaggio
- LSP Client, funge da collegamento tra documento, server e utente.
  Parsa il documento, inoltra le richieste dell'utente al server e ne mostra le risposte
- LSP Server, interpreta il testo parsato e fornisce al client le risposte alle query dell'utente
  eg. goToDefinition -> page+line definizione

### Autoformatting

## DAP

[Debugger Adapter Protocol]('https://microsoft.github.io/debug-adapter-protocol')
