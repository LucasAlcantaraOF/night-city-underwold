// GangReputation.reds
// Fase 1 do NCU
// Hook no sistema de combate para capturar mortes de membros de facções

@wrapMethod(ScriptedPuppet)
protected cb func OnDeath(evt: ref<gameDeathEvent>) -> Bool {
    // 1. O motor do jogo executa a lógica original de morte primeiro
    let result = wrappedMethod(evt);
    
    // 2. Nossa lógica (injeta no motor): V checa quem morreu
    let target = this;
    let instigator = evt.instigator; // Quem matou?
    
    if IsDefined(instigator) && instigator.IsPlayer() {
        // Obter a Filiação da Gangue do NPC morto (Affiliation)
        let ncuAffiliation = target.GetRecord().Affiliation().EnumName();
        
        // Log básico apenas se for gangue válida
        if Equals(ncuAffiliation, "Maelstrom") || 
           Equals(ncuAffiliation, "Valentinos") || 
           Equals(ncuAffiliation, "VoodooBoys") ||
           Equals(ncuAffiliation, "SixthStreet") ||
           Equals(ncuAffiliation, "TygerClaws") ||
           Equals(ncuAffiliation, "Animals") ||
           Equals(ncuAffiliation, "Scavengers") {
           
           // A lógica final de RedScript será enviar um sinal para o CET
           // Atualizando "database.json" para subtrair reputação daquela gangue (-10 pontos)
           LogChannel(n"DEBUG", "NCU: Jogador eliminou um membro da gangue: " + ncuAffiliation);
           
           // Todo: Função customizada "NCU_UpdateReputation(ncuAffiliation, -10);"
        }
    }
    
    return result;
}
