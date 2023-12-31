# Day 16-24: Starting SwiftUI

> Created: October 11, 2023 12:21 PM
> 
> Level: basic
> 
> Date: 2023/10/06 → 2023/10/18


📎 **공부하면서 알게된 키워드, 개념을 작성합니다.**
<!--
  <details>
  <summary>Table</summary>
  <div markdown="1">       
    <ul>
      <li><a href="#-Day-16">Day 16</a></li>
      <li><a href="#-Day-17">Day 17</a></li>
      <li><a href="#-Day-18">Day 18</a></li>
      <li><a href="#-Day-19">Day 19</a></li>
      <li><a href="#-Day-20">Day 20</a></li>
      <li><a href="#-Day-21">Day 21</a></li>
      <li><a href="#-Day-23">Day 23</a></li>
    </ul>
  </div>
  </details>
-->

# **Day 16**

> WeSplit
> 
- Bundle identifier
- View, **some View**
- **NavigationStack**, **navigationTitle**, navigationTitleDisplaymode
- **Form, Section**
- **@State**
    - 구조체에서 프로퍼티 값을 변경할 수 없다. (상수로 선언될 수 있기 때문) 그러므로 mutating 키워드가 붙은 func에서 프로퍼티 값을 변경해야 한다. 근데 SwiftUI에서는 @State라는 property wrapper를 사용하여 프로퍼티 상태를 변화하게 해준다.
    - 하나의 뷰에 저장되는 간단한 프로퍼티를 위해 특별히 설계된 것이므로, 예외 사항이 없다면 private 키워드를 붙여주도록 하자.
- **Property wrapper**
- **two-way binding** ($)
    - show the value of this property here, *but write any changes back to the property*.
    ex) Textfield에 property 값을 바인딩하는 동시에 Textfield값이 변경되면 property도 업데이트되도록 바인딩하는 것
    - 그냥 Property의 값만 읽으면 two-way binding이 아니다. $ 기호를 사용하면 읽는 것 뿐만 아니라 쓰는 것도 가능해지는 two-way binding이 된다.
- **ForEach**, **id:\.self**

# **Day 17**

> WeSplit
> 
- **TextField**
    - **format**을 설정하여 입력받을 값의 형식을 지정해버릴 수 있다. 특히 TextField는 String입력을 선호하므로 Double이나 Int값을 text로 지정할 경우 format을 설정해주도록 하자.
    ex) TextField(“Amout”, value: $amout, format: .currency(code: “USD”) <- 미국 통화 표기로 입력하도록 한다.
    - **localize**도 할 수 있다. 
    ex) .currency(code: Locale.current.currency?.identifier ?? “USD”)
    - **keyboardType**
- Locale
    - 사용자의 모든 지역 설정(사용하는 달력, 수천 자리 숫자를 구분하는 방법, 미터법 사용 여부 등)을 저장하는 역할을 하는 iOS에 내장된 대규모 구조체
- **Picker**
    - .pickerStyle
- Section
    - header
- **@FocusState**
- Spacer()

# **Day 18**

> WeSplit
> 
- Challenge
    1. ✅Add a header to the third section, saying “Amount per person”
    2. ✅Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
    3. ✅Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.

---

# **Day 19**

> Challenge 1
> 
- You need to build an app that **handles unit conversions**: users will select an input unit and an output unit, then enter a value, and see the output of the conversion.
- 온도, 길이, 시간, 부피 변환 중에서 택 1
- 들어가야할 것
    - 입력 단위 선택을 위한 segmented control
    - 출력 단위 선택을 위한 segmented control
    - 사용자가 숫자를 입력할 text field
    - 변환된 숫자를 보여줄 text view

# **Day 20**

> Guess the Flag
> 
- 세계의 여러 국기를 배우는 데 도움이 되는 추측 게임
- 배우게 될 것: stacks, buttons, images, alerts, asset catalogs, and more.
- **HStack, VStack, ZStack**: 수평, 수직, 깊이(depth) 정렬
    - alignment: H,V,Z
    - spacing: H,V
    - ZStack은 위에서부터 아래로, 뒤에서부터 앞으로 컨텐츠를 그린다.
- **ZStack + Color**: 전체 화면 색상 입히기
    - ZStack의 가장 윗쪽에 **Color.red**를 하면 배경 색상이 빨간색이 된다.
    - safe area까지 색상을 지정하고 싶다면 ZStack에 **.ignoreSafeArea()** 모디파이어를 넣어주자.
    - **.background(.ultraThinMaterial)**: 배경 효과로 유리창에 뒷쪽이 불투명하게 보이는 효과를 줄 수 있다.
- Gradients: 표시할 색상 배열, 크기 및 방향 정보, 사용할 그라데이션 유형
    - **LinearGradient:** 선형 (startPoint, endPoint)
    ex) LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
    ex) LinearGradient(**stops**: [ Gradient.Stop(color: .white, location: 0.45), Gradient.Stop(color: .black, location: 0.55), ], startPoint: .top, endPoint: .bottom)
    - **RadialGradient**: 원형 (startRadius, endRadius)
    - **AngularGradient**: 방사형 (center)
    - .background(.red**.gradient**)
- **Button**: action, role, label
    - .buttonStyle
    - 당연히 이미지를 label로 넣어서 이미지 버튼을 만들 수도 있음
- **Image**: 프로젝트에 저장된 이미지 이름이나 시스템 이미지 이름을 작성해주면 된다.
    - Image("pencil”): pencil이라는 이름을 가진 이미지
    - Image(decorative: "pencil"): 위와 동일하나, 화면 리더기로 읽히지 않음
    - Image(systemName: "pencil”): 시스템이 가지고 있는 pencil 아이콘
- **Alert**: 일림 메세지, 알림이 표시되어야 하는 조건을 설정해두고 해당 조건이 참이되면 알림 창이 뜬다.
    - 알림이 뜨는 조건은 Bool 타입의 State 프로퍼티로 만든다.
    - **.alert**(“Title”, isPresented: $showingAlert) { Button(“ok”) { } }
    - 위의 알림 모디파이어는 어떤 컴포넌트에 붙어도 상관없다. 그냥 가장 큰 컨테이너 아래에 붙이는게 일반적인듯
    - 알림 모디파이어 내부에 버튼을 설정할 수 있다. 이때 버튼에 role을 설정해주면 취소, 확인 버튼을 명확히 구분할 수 있다. + 후행 클로저에 아무것도 없어도 자동으로 알림 창이 dismiss되므로, 추가 기능을 작성해주면 된다.

# **Day 21**

> Guess the Flag
> 
- **Font**
    - .font( 고유크기 지정 가능 )
- **Shape**
    - .clipShape()
    - .shadow(radius:)

# **Day 23**

> View, Modifier
> 
> - Custom modifier와 custom container를 만들면서 SwiftUI가 내부적으로 동작하는 방식을 알아보자.
1. **SwiftUI가 View를 Struct로 사용하는 이유는?**
    - **성능(Performance)**
        - UIKit과 AppKit은 Class를 사용하며 struct는 class보다 간단하고 빠르다.
        - UIKit에서 모든 뷰는 UIView로, class이다. 이들은 여러가지 property와 method(제약조건, 콘텐츠 랜더링을 위한 레이어 등)를 모두 가지고 있으며 UIView의 하위 뷰는 이 모든 것들을 가져야 한다.
        - 그러나 SwiftUI의 뷰는 struct로 만들어져 있으며 모든 뷰는 각자의 정보만 가지고 있다. 그 이상 포함되는 것은 없다. 그러므로 아주 많은 뷰를 만드는 것에 유리하다 (??)
    - **상태(State)**를 더 깔끔하게 분리할 수 있기 때문이다.
        - UI를 업데이트하기 위해 값이 변경된 시기를 SwiftUI는 어떻게 알까? ‘시간이 지나도 변경되지 않는 뷰==struct’를 생성하여 그 시기를 알 수 있게 한다.
        - class는 값을 자유롭게 변경할 수 있기 때문에 코드가 지저분해질 수 있지만, SwiftUI는 그렇지 않다는 것!
        - SwiftUI는 데이터를 UI로 변환하는 단순하고 비활성 뷰를 만든다.
2. **main SwiftUI View의 뒤에는 무엇이 있나요?**
    - 메인 스유 뷰 뒤에는 아무것도 없다!
        - 그래서 가장 바깥 VStack에 배경색을 넣어도 모든 뒷 배경이 해당 색으로 변하지 않는다. 변하게 하려면 frame을 만져줘야 한다.
    - 사실 `UIHostingController`라는 게 있지만, 해당 코드를 수정하면 문제가 발생할 수 있으므로 SwiftUI View의 뒤에는 어떠한 것도 없다라고 생각하는게 맞다.
3. **modifier의 순서는 왜 중요한가요?**
    - SwiftUI의 View는 modifier가 적용될 때마다 새로운 View를 반환하는 형식이다. 그러므로 순서에 따라 새로운 뷰가 만들어지므로 modifier의 순서에 따라 다른 모양의 뷰가 그려진다.
    - modifier가 적용된 뷰의 type은 `ModifiedContent`로, 해당 타입이 계속 쌓인다(stacking up). 각 뷰를 수정하는게 아니라 기존 뷰와 변환될 타입이 적용된 새로운 뷰가 계속 쌓이는 것이다.
        - SwiftUI에서는 뷰에 modifier를 적용할 때마다 generic을 사용하여 해당 modifier를 적용한다. 
        `ModifiedContent<OurThing, OurModifier>`
        - 여러 개의 modifier를 적용하면 `ModifiedContent<ModifiedContent<…>>` 이런 식으로 쌓여간다.

```swift
Button("Hello, world!") {
	print(type(of: self.body))
}
.frame(width: 200, height: 200)
.background(.red)
```

- 위의 코드의 type을 출력해보면 다음과 같이 나온다.
`ModifiedContent<ModifiedContent<Button<Text>, _BackgroundStyleModifier<Color>>, _FrameLayout>`
    - SwiftUI가 modifier마다 새로운 view를 랜더링하는 것처럼 보인다. 그러나 과정만 비슷하게 이해하고, 정말로 이렇게 작용하는 것은 아니라는 것을 기억하자. (만약 그렇다면 성능이 끔찍하게 떨어질 것) 새로운 뷰를 계속 render하는건 아니다.
1. **SwiftUI는 왜 view type으로 ‘some View’를 사용하나요?**
    - swift의 강력한 기능인 불투명한 타입(opaque return type)을 SwfitUI가 굉장히 많이 의존하고 있다. some View가 불투명한 타입으로, 이는 “이 객체는 View 프로토콜을 따르고 있어! 근데 어떤 객체인지 말하지는 않을게”라고 명시하는 것이다. 그렇다면 왜 SwiftUI는 이러한 some View를 쓰는 것일까?
    - View 프로토콜에는 associated type이 첨부되어 있다. 이는 View 자체로는 아무 의미가 없으며 어떤 종류의 view인지 정확히 말해야한다는 Swift의 방식이다. 문자열 배열을 “이 변수는 배열입니다”라고 말할 수 없고 “이 변수는 문자열 배열입니다”라고 배열의 내부까지 말해줘야 한다. 정확하게 내부까지 알려줘야하는 것이다. 그렇지 않으면 구멍이 뻥 뚫려있는 것과 마찬가지로 SwiftUI가 내부의 형태를 알지 못해서 인터페이스의 변화를 적용하는데 많은 시간이 걸릴 것이다.
        - 그러므로 body property의 리턴 타입이 그냥 View이면 일반 View를 리턴한다는 뜻이지 Text나 Button같은 특정 view가 될 수 없다.
        - body가 Text 1개만 사용하고 있다면(modifier없이) body의 타입은 Text가 된다.
        - Button에 modifier가 붙어있다면 2번의 내용처럼 `ModifiedContent<..>`가 된다.
    - 정확한 타입값을 매번 지정해주는건 너무 어렵고 귀찮은 작업이다. 그래서 Swift에게 정확한 타입을 알려주기 보다는 “View를 준수하는 어떤 타입들이 들어올거야~ 근데 정확하게는 말하지 않을게”라고 해주는 것이다. 이를 some View 타입이 해준다.
    - VStack 내부에 2개의 Text 뷰가 있으면 어떤 타입이 될까?
        - SwiftUI는 VStack을 2개의 Text가 담긴 TupleView로 생성한다.
        - 그러므로 Stack { Text Text }은 “어떤 종류의 뷰가 있나요?”라는 물음에 “2개의 Text뷰가 있는 TupleView입니다”로 대답하게 된다.
    - body 프로퍼티에 여러 개의 뷰를 리턴하면 어떻게 될까? (하나로 묶지 않고 단일로 여러 개를 작성할 경우)
        - body 프로퍼티는 @ViewBuilder라는 특별한 속성을 가지고 있기 때문에 여러 개의 뷰를 자동으로 TupleView로 wrapping한다. 결국 여러 개의 뷰를 리턴한 것처럼 보여도 하나의 TupleView로 결합된다.
        `@ViewBuilder @MainActor var body: Self.Body { get }`
2. **Conditional Modifier**
    - 특정 조건이 충족되어야만 활성화되는 modifier의 경우, 삼항 연산자를 쓰는 것이 가장 좋다.
    - 조건에 따라 modifier의 사용이 바뀐다.
    - if 문을 사용할 수도 있지만 그럴 경우 SwiftUI가 더 많은 일을 하게 된다. 조건문에 따라 뷰가 완전히 파괴되었다가 새로 만들어지기 때문이다. 삼항 연산자를 쓰면 하나의 view로 인식하여 해당 modifier 부분만 새롭게 적용된다.
3. **Environment Modifier**
    - 여러 개의 뷰에 동시에 동일한 효과를 적용하는 modifier이다.
        - `.font()`가 대표적인 Environment modifier이다.
    - 동일한 Environment modifier를 상위와 하위 뷰에 사용하는 경우, 하위 뷰에 적용된 modifier가 우선된다.
    - Environment modifier는 regular modifier와 비슷하게 생겼지만 다르게 작동한다.
        - regular modifier의 예로 `.blur()`가 있는데 이를 container에 적용할 경우 container 내부가 아니라 자체에 blur 효과가 적용된다.
    - 공식 문서로 Environment modifier와 regular modifier를 구분하도록 하자.
4. **View as properies**
    - View를 property에 할당하여 사용할 수 있다. body에서 호출하면 일반 View랑 동일하게 작동한다.
        - stored property, computed property 모두 만들 수 있다.
        - 단 view가 들어있는 stored property에 다른 stored property를 호출할 수 없다.
    - computed property로 만들 경우 body와 달리 ViewBuilder가 자동으로 적용되지 않으므로 주의해야 한다.
        - 여러 개의 뷰를 computed property로 body에 사용하 경우, 3가지 방법으로 처리할 수 있다.
        (1) VStack으로 묶기
        (2) Group으로 묶기
        (3) @ViewBuilder 적용하기
5. **View composition**
    - View가 복잡할 경우 분할할 수 있다.
    - 기존 View 구조체처럼, 분할하고 싶은 View를 새로운 구조체로 생성하면 된다.
6. **Custom modifiers**
    - 사용자 정의 modifier를 만들 수 있다.
        - modifier 셋을 여러 곳에 동일하게 지정해야 할 경우, custom modifier를 만들면 코드가 더욱 간결해진다.
    - `.font()`, `.background()`, `.clipShape()`처럼 사용하고 싶다면 View의 extension으로 custom modifier를 modifier안에 담아서 리턴해주는 메서드를 추가해주자.
    - custom modifier로 modifier를 추가하는 것 말고도 새로운 뷰 구조를 만들 수도 있다.
        - content를 View 구조안에 넣어서 작업하면 된다.
7. **Custom container**
    - 사용자 정의 container를 만들 수 있다.
        - VStack, HStack 처럼 다른 뷰를 담을 수 있는 View Container.
    - custom modifier와 동일하게 단일 struct를 만들면 되나, generic를 사용하여 container가 안에 들어올 콘텐츠 타입을 정의해주자. View로 하면 된다.
        - `struct CustomContainer<Content: View>: View { .. }`
    - container가 품을 콘텐츠(content) 프로퍼티를 만들어주자.
        - `@ViewBuilder let content: () -> Content`
        - 뷰빌더는 없어도 되긴하나… 추가를 하면 다수의 뷰를 리턴하는데 번거로움을 줄일 수 있다.
