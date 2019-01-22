// This is a test harness for your module
// You should do something interesting in this harness
// to test out the module and to provide instructions
// to users on how to use it by example.

var onboarding = require('ti.onboarding');

var win = Ti.UI.createWindow({
	backgroundColor:'white'
});
var onboardingView = onboarding.createView({
	items: [{
		title: "Hotels",
		descriptions: "All hotels and hostels are sorted by hospitality rating"
	}]
})
win.add(onboardingView);
win.open();
