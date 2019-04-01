// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

var onboarding = require('ti.onboarding')

var onboardingView = onboarding.createView({
  items: [
    {
      title: 'Titanium + Swift',
      description: 'Native modules can now be written in Swift!',
      informationImage: '/images/titanium-logo.png',
      pageIcon: '/images/titanium-logo.png'
    },
    {
      title: 'Get Swifty',
      description: 'Use all the neat Swift features in your module!',
      informationImage: '/images/swift-logo.png',
      pageIcon: '/images/swift-logo.png',
      color: '#ff9500'
    }
  ]
  /*
	// Optional callbacks
  beforeTransition: index => {
    console.log(`beforeTransition ${index}`)
  },
  afterTransition: index => {
    console.log(`afterTransition ${index}`)
	},

	// Optional default values
  defaultItemColor: 'blue',
  defaultItemTitleColor: 'yellow',
  defaultItemDescriptionColor: '#e6e6e6',
	defaultItemTitleFont: { size: 32 }
	defaultItemDescriptionFont: 'Roboto'

	// Optional page indicator customization
	pageItemColor: index => {
    return 'red'
	},
	pageItemRadius: 10
	pageItemSelectedRadius: 20
	*/
})

let win = Ti.UI.createWindow()
win.add(onboardingView)
win.open()
