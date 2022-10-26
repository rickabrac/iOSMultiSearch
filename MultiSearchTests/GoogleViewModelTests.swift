//
//  GoogleViewModelTests.swift
//  MultiSearchTests
//  Created by Rick Tyler
//

import XCTest
@testable import MultiSearch

class GoogleViewModelTests: XCTestCase {
	
	func testGoogleViewModel() throws {
		let api = GoogleAPI(cannedResponseFileName: "GoogleStubResult")
		let vm = GoogleViewModel(api: api)

		vm.search("?")
		XCTAssert(vm.searchInProgress())
		sleep(2)
		XCTAssertFalse(vm.searchInProgress())
		
		guard let items = vm.items else {
			XCTAssert(false)
			return
		}
		
		XCTAssert(vm.numberOfRowsInSection(section: 0) == 10)
			
		for i in 0..<items.count {
			let indexPath = IndexPath(row: i, section: 0)
			XCTAssertEqual(stubUrls[i], vm.urlForRowAt(indexPath: indexPath))
			XCTAssertEqual(stubTexts[i], vm.textForRowAt(indexPath: indexPath))
		}
	}
}

var stubUrls = [
	"https://www.cs.utexas.edu/users/dastuart/jdir/",
	"http://www.cs.cmu.edu/afs/cs/academic/class/15612-s97/class/lmichaud/joke.htm",
	"https://www.cs.utexas.edu/~scottm/fb/J_Moore_fss-talk.pdf",
	"https://courses.cs.vt.edu/~cs3214/spring2015/projects/student-plugins//wvicto7_aaronk1/joke/",
	"http://www.cs.cornell.edu/courses/cs519/2002sp/hw3_tcphijack_questions.html",
	"https://www.cs.ubc.ca/~davet/music/track/RETRO80S_001/RETRO80S_001-15.html",
	"https://www.cs.dartmouth.edu/~cs50/Lectures/c3/activity2.html",
	"https://www.cs.dartmouth.edu/campbell/cs65/2013/assessment.pdf",
	"https://student.cs.uwaterloo.ca/~shwen/misc/random.html",
	"http://www.cs.cmu.edu/afs/cs/academic/class/15494-s20/labs/lab6/lab6.html"
]
	
var stubTexts = [
	"Under Construction. Joke Index Page. I am working on setting up some html joke pages. They contain things off the net, that I've seen/heard on TV, ...",
	"Jokes. Once upon a time there was two belgiums guys riding in a truck around Bruxell. There comes a bridge in front of them. A sign says 6 feet maximum ...",
	"The glorified closet, the subject of a running joke on the comedy show, now in its 31st season, can simultaneously house a wisecracking ... 3. Page 4 ...",
	"Index of /~cs3214/spring2015/projects/student-plugins/wvicto7_aaronk1/joke. [ICO], Name · Last modified · Size · Description. [PARENTDIR] ...",
	"The network set up was as follows: a LinkSys Cable Router/DHCP Server (not connected to the Internet), a laptop running Windows 2000, a laptop running Linux and ...",
	"Lyrics. Original Source: LyricWiki. We must play our lives like soldiers in the field. The life is short, I'm running faster all the time",
	"An example of running it with three file names, where joke file does not exist: $ ./fileIO labs/lab1-xia-z/query.sh joke labs/lab1-xia-z/README.md ...",
	"Mar 18, 2013 ... And although terrible those jokes really added a nice touch to the class. ... Update the lecture notes, it's frustrating that you joke about ...",
	"Biggest Joke in CS350. There is this mysterious file in CS350's common directory which indicates. PLEASE USE THIS FILE TO LOG ANY CHANGES TO FILES IN THIS ...",
	"Feb 18, 2017 ... Program Cozmo to respond to the command \"Cozmo tell me a joke\". Does speech recognition work for you? Homework."
]
