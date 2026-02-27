// Night City Underworld (NCU) - Integração com Phone Extension Framework
// Contatos: Yelena (fixer veículos) e Ian (fixer gangues). Apenas primeiro diálogo (greeting do contacts.lua), sem respostas.
// Requer: Phone Extension Framework (Nexus 24949) instalado.

module NCU.Phone
import PhoneExtension.DataStructures.*
import PhoneExtension.Classes.*
import PhoneExtension.System.*

// Hashes únicos para os contatos (evitar colisão com outros mods)
public static func NCUYelenaContactHash() -> Int32 = 45705710
public static func NCUIanContactHash() -> Int32 = 45705711

// Persistência: só "intro já mostrada" para não repetir o pop-up no HUD
public class NCUPersistenceSystem extends ScriptableSystem {
	private persistent let m_yelenaIntroShown: Int32 = 0;
	private persistent let m_ianIntroShown: Int32 = 0;

	public static func GetInstance(obj: ref<GameObject>) -> ref<NCUPersistenceSystem> {
		let gi: GameInstance = obj.GetGame();
		return GameInstance.GetScriptableSystemsContainer(gi).Get(n"NCU.Phone.NCUPersistenceSystem") as NCUPersistenceSystem;
	}

	public func WasYelenaIntroShown() -> Bool = this.m_yelenaIntroShown != 0
	public func WasIanIntroShown() -> Bool = this.m_ianIntroShown != 0
	public func SetYelenaIntroShown() -> Void { this.m_yelenaIntroShown = 1; }
	public func SetIanIntroShown() -> Void { this.m_ianIntroShown = 1; }
}

// --- Yelena (Veículos, Corridas Clandestinas e Desmanches) - greeting = contacts.lua car_fixer.greeting ---
public class NCUYelenaPhoneListener extends PhoneEventsListener {
	private let m_messengerController: wref<MessengerDialogViewController>;

	public func GetContactHash() -> Int32 {
		return NCUYelenaContactHash();
	}

	private func GetGreetingYelena() -> String {
		return s"Aí, V. Meu nome é Yelena. Me disseram que você manda bem no volante e não faz muitas perguntas. Eu gerencio uns desmanches clandestinos pelas Badlands e Watson. O negócio é o seguinte: tenho figurões pagando fortunas por 'Carros Exóticos'. E por exótico, eu digo relíquias impecáveis antes desse mundo ficar uma merda. Máquinas a combustão pura de antigamente, manja? Em 2077 essas lendas de aço esquecidas valem mais que muito cromo. Se quiser levantar uns bons edinhos roubando essas naves de colecionadores... ou provar que domina as ruas nessas mesmas máquinas, me dá um toque. Se eu gostar do teu serviço, a gente pode até descolar uma possibilidade de você lucrar com isso também, vai que você fica com algum desses carros.";
	}

	public func GetContactData(isText: Bool) -> ref<ContactData> {
		let contactData: ref<ContactData> = new ContactData();
		contactData.hash = this.GetContactHash();
		contactData.localizedName = s"Yelena";
		contactData.contactId = s"NCU_CarFixer";
		contactData.id = s"NCU_YEL";
		contactData.avatarID = t"PhoneAvatars.Avatar_Unknown";
		contactData.questRelated = true;
		contactData.isCallable = false;
		if isText {
			contactData.type = MessengerContactType.SingleThread;
			contactData.lastMesssagePreview = s"Aí, V. Meu nome é Yelena. Me disseram que você manda bem no volante...";
		} else {
			contactData.type = MessengerContactType.Contact;
		};
		contactData.messagesCount = 1;
		contactData.hasMessages = true;
		contactData.playerIsLastSender = false;
		return contactData;
	}

	public func ShowDialog(messengerController: wref<MessengerDialogViewController>) -> Bool {
		this.m_messengerController = messengerController;
		messengerController.PushMessageCustom(this.GetGreetingYelena(), MessageViewType.Received, s"Yelena", true);
		messengerController.m_scrollController.SetScrollPosition(1.00);
		return true;
	}

	public func ActivateReply(messageID: Int32) -> Void {
		// Sem respostas: apenas primeiro diálogo (greeting)
	}
}

// --- Ian (Reputação, Acerto de Contas e Controle de Território) - greeting = contacts.lua gang_fixer.greeting ---
public class NCUIanPhoneListener extends PhoneEventsListener {
	private let m_messengerController: wref<MessengerDialogViewController>;

	public func GetContactHash() -> Int32 {
		return NCUIanContactHash();
	}

	private func GetGreetingIan() -> String {
		return s"Iae Filha da Puta, tudo bem? As gangues de Night City estão passando da porra dos limites e eu trabalho mantendo a balança de poder do jeito certo, ta ligado caralho?. Preciso de um executor para meter o pau na mesa e mandar medir. Alguém pra cobrar dívidas, apagar alvos problemáticos e mostrar pra essas facções de merda quem é que manda nos territórios. Se você fizer o trabalho sujo por mim, garanto que o seu nome será respeitado até pelo líder mais casca-grossa da Maelstrom, e ele vai querer mamar suas bolas. Não fode comigo, se não eu vou foder com você.";
	}

	public func GetContactData(isText: Bool) -> ref<ContactData> {
		let contactData: ref<ContactData> = new ContactData();
		contactData.hash = this.GetContactHash();
		contactData.localizedName = s"Ian";
		contactData.contactId = s"NCU_GangFixer";
		contactData.id = s"NCU_IAN";
		contactData.avatarID = t"PhoneAvatars.Avatar_Unknown";
		contactData.questRelated = true;
		contactData.isCallable = false;
		if isText {
			contactData.type = MessengerContactType.SingleThread;
			contactData.lastMesssagePreview = s"Iae Filha da Puta, tudo bem? As gangues de Night City estão passando da porra...";
		} else {
			contactData.type = MessengerContactType.Contact;
		};
		contactData.messagesCount = 1;
		contactData.hasMessages = true;
		contactData.playerIsLastSender = false;
		return contactData;
	}

	public func ShowDialog(messengerController: wref<MessengerDialogViewController>) -> Bool {
		this.m_messengerController = messengerController;
		messengerController.PushMessageCustom(this.GetGreetingIan(), MessageViewType.Received, s"Ian", true);
		messengerController.m_scrollController.SetScrollPosition(1.00);
		return true;
	}

	public func ActivateReply(messageID: Int32) -> Void {
		// Sem respostas: apenas primeiro diálogo (greeting)
	}
}

// Pop-up SMS no HUD (notificação atrasada de intro)
public class NCUIntroNotificationCallback extends DelayCallback {
	private let m_player: wref<GameObject>;
	private let m_contactHash: Int32;
	private let m_title: String;
	private let m_text: String;

	public static func Create(player: ref<GameObject>, contactHash: Int32, title: String, text: String) -> ref<NCUIntroNotificationCallback> {
		let cb: ref<NCUIntroNotificationCallback> = new NCUIntroNotificationCallback();
		cb.m_player = player;
		cb.m_contactHash = contactHash;
		cb.m_title = title;
		cb.m_text = text;
		return cb;
	}

	public func Call() -> Void {
		let syst = PhoneExtensionSystem.GetInstance(this.m_player);
		if IsDefined(syst) {
			syst.NotifyNewMessageCustom(this.m_contactHash, this.m_title, this.m_text);
		};
		let ncuPersist = NCUPersistenceSystem.GetInstance(this.m_player);
		if IsDefined(ncuPersist) {
			if this.m_contactHash == NCUYelenaContactHash() {
				ncuPersist.SetYelenaIntroShown();
			};
			if this.m_contactHash == NCUIanContactHash() {
				ncuPersist.SetIanIntroShown();
			};
		};
	}
}

@addField(NewHudPhoneGameController)
private let m_ncuYelenaContact: ref<NCUYelenaPhoneListener>;

@addField(NewHudPhoneGameController)
private let m_ncuIanContact: ref<NCUIanPhoneListener>;

@wrapMethod(NewHudPhoneGameController)
protected cb func OnInitialize() -> Bool {
	let ret: Bool = wrappedMethod();
	let syst = PhoneExtensionSystem.GetInstance(this.GetPlayerControlledObject());
	let player: ref<GameObject> = this.GetPlayerControlledObject();
	let gi: GameInstance = player.GetGame();

	if !IsDefined(this.m_ncuYelenaContact) {
		this.m_ncuYelenaContact = new NCUYelenaPhoneListener();
	};
	if !IsDefined(this.m_ncuIanContact) {
		this.m_ncuIanContact = new NCUIanPhoneListener();
	};
	syst.Register(this.m_ncuYelenaContact);
	syst.Register(this.m_ncuIanContact);

	let ncuPersist = NCUPersistenceSystem.GetInstance(player);
	let delaySys = GameInstance.GetDelaySystem(gi);
	if IsDefined(delaySys) && IsDefined(ncuPersist) {
		if !ncuPersist.WasYelenaIntroShown() {
			delaySys.DelayCallback(NCUIntroNotificationCallback.Create(player, NCUYelenaContactHash(), s"Yelena", s"Aí, V. Meu nome é Yelena. Me disseram que você manda bem no volante e não faz muitas perguntas. Eu gerencio uns desmanches clandestinos pelas Badlands e Watson. O negócio é o seguinte: tenho figurões pagando fortunas por 'Carros Exóticos'. E por exótico, eu digo relíquias impecáveis antes desse mundo ficar uma merda. Máquinas a combustão pura de antigamente, manja? Em 2077 essas lendas de aço esquecidas valem mais que muito cromo. Se quiser levantar uns bons edinhos roubando essas naves de colecionadores... ou provar que domina as ruas nessas mesmas máquinas, me dá um toque. Se eu gostar do teu serviço, a gente pode até descolar uma possibilidade de você lucrar com isso também, vai que você fica com algum desses carros."), 4.0, false);
		};
		if !ncuPersist.WasIanIntroShown() {
			delaySys.DelayCallback(NCUIntroNotificationCallback.Create(player, NCUIanContactHash(), s"Ian", s"Iae Filha da Puta, tudo bem? As gangues de Night City estão passando da porra dos limites e eu trabalho mantendo a balança de poder do jeito certo, ta ligado caralho?. Preciso de um executor para meter o pau na mesa e mandar medir. Alguém pra cobrar dívidas, apagar alvos problemáticos e mostrar pra essas facções de merda quem é que manda nos territórios. Se você fizer o trabalho sujo por mim, garanto que o seu nome será respeitado até pelo líder mais casca-grossa da Maelstrom, e ele vai querer mamar suas bolas. Não fode comigo, se não eu vou foder com você."), 7.0, false);
		};
	};

	return ret;
}

@wrapMethod(NewHudPhoneGameController)
protected cb func OnUninitialize() -> Bool {
	let ret: Bool = wrappedMethod();
	let syst = PhoneExtensionSystem.GetInstance(this.GetPlayerControlledObject());
	if IsDefined(syst) {
		if IsDefined(this.m_ncuYelenaContact) {
			syst.Unregister(this.m_ncuYelenaContact);
		};
		if IsDefined(this.m_ncuIanContact) {
			syst.Unregister(this.m_ncuIanContact);
		};
	};
	return ret;
}
