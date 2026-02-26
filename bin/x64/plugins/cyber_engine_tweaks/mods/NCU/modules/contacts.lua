-- contacts.lua
-- Gerencia os Dois Fixers principais do mod (Definições)

local Contacts = {
    car_fixer = {
        id = "car_fixer",
        name = "Yelena",
        domain = "Veículos, Corridas Clandestinas e Desmanches",
        greeting = "Aí, V. Meu nome é Yelena. Me disseram que você manda bem no volante e não faz muitas perguntas. Eu gerencio uns desmanches clandestinos pelas Badlands e Watson. O negócio é o seguinte: tenho figurões pagando fortunas por 'Carros Exóticos'. E por exótico, eu digo relíquias impecáveis antes desse mundo ficar uma merda. Máquinas a combustão pura de antigamente, manja? Em 2077 essas lendas de aço esquecidas valem mais que muito cromo. Se quiser levantar uns bons edinhos roubando essas naves de colecionadores... ou provar que domina as ruas nessas mesmas máquinas, me dá um toque. Se eu gostar do teu serviço, a gente pode até descolar uma possibilidade de você lucrar com isso também, vai que você fica com algum desses carros?"
        -- Colocar para o Jogador ter que completar 10 missões de desmanche/roubo para aparecer os contratos de Roubo de Carro para o Pessoal
    },
    gang_fixer = {
        id = "gang_fixer",
        name = "Ian",
        domain = "Reputação, Acerto de Contas e Controle de Território",
        greeting = "Iae Filha da Puta, tudo bem? As gangues de Night City estão passando da porra dos limites e eu trabalho mantendo a balança de poder do jeito certo, ta ligado caralho?. Preciso de um executor para meter o pau na mesa e mandar medir. Alguém pra cobrar dívidas, apagar alvos problemáticos e mostrar pra essas facções de merda quem é que manda nos territórios dessa bosta. Se você fizer o trabalho sujo por mim, garanto que o seu nome será respeitado até pelo líder mais casca-grossa da Maelstrom, e ele vai querer mamar suas bolas."
    }
}

function Contacts:init(ncuCore)
    print("[NCU:Contacts] Módulo de Contatos inicializado.")
    print("[NCU:Contacts] Fixer Ativo: " .. self.car_fixer.name)
    print("[NCU:Contacts] Fixer Ativo: " .. self.gang_fixer.name)
    
    -- Chama a verificação da mensagem inicial logo após iniciar, checando o "save" do mod
    self:CheckFirstTimeIntro(ncuCore.data)
end

function Contacts:CheckFirstTimeIntro(db)
    if not db or not db.contacts then return end

    -- Apresentação da Yelena
    if db.contacts.car_fixer and db.contacts.car_fixer.discovered == false then
        print("\n====================================================")
        print("� O HUD PISCA: MENSAGEM CRIPTOGRAFADA RECEBIDA")
        print("====================================================")
        print("👤 Remetente: Desconhecido (Yelena) [PING DE WATSON]")
        print("----------------------------------------------------")
        print("Mensagem: " .. self.car_fixer.greeting)
        print("----------------------------------------------------")
        print("[SISTEMA HUD]: Arquivo 'Yelena_Contato.vcf' transferido.")
        print("====================================================\n")
        
        db.contacts.car_fixer.discovered = true
    end

    -- Apresentação do Ian
    if db.contacts.gang_fixer and db.contacts.gang_fixer.discovered == false then
        -- Simula um delay ou uma nova entrada separada
        print("\n====================================================")
        print("📱 O HUD PISCA: CONEXÃO DIRETA ESTABELECIDA")
        print("====================================================")
        print("👤 Remetente: Desconhecido (Ian) [PING DE HEYWOOD]")
        print("----------------------------------------------------")
        print("Mensagem: " .. self.gang_fixer.greeting)
        print("----------------------------------------------------")
        print("[SISTEMA HUD]: Número de Ian gravado na agenda.")
        print("====================================================\n")
        
        db.contacts.gang_fixer.discovered = true
    end
end

return Contacts
