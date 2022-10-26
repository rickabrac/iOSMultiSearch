//
//  DuckDuckGoViewModelTests.swift
//  MultiSearchTests
//  Created by Rick Tyler
//

import XCTest
@testable import MultiSearch

class DuckDuckGoViewModelTests: XCTestCase {
	
    func testDuckDuckGoViewModel() throws {
		let api = DuckDuckGoAPI(cannedResponseFileName: "DuckDuckGoStubResult")
		let vm = DuckDuckGoViewModel(api: api)

		vm.search("?")
		XCTAssert(vm.searchInProgress())
		sleep(2)
		XCTAssertFalse(vm.searchInProgress())
		
		guard let items = vm.items else {
			XCTAssert(false)
			return
		}
		
		XCTAssert(vm.numberOfRowsInSection(section: 0) == 28)
			
		for i in 0..<items.count {
			let indexPath = IndexPath(row: i, section: 0)
			XCTAssertEqual(stubUrls[i], vm.urlForRowAt(indexPath: indexPath))
			XCTAssertEqual(stubTexts[i], vm.textForRowAt(indexPath: indexPath))
		}
    }
	
	var stubUrls = [
		"https://duckduckgo.com/Test_cricket",
		"https://duckduckgo.com/Test_(wrestler)",
		"https://duckduckgo.com/Test_(assessment)",
		"https://duckduckgo.com/Test_(2013_film)",
		"https://duckduckgo.com/Test_(2014_film)",
		"https://duckduckgo.com/Test_(group)",
		"https://duckduckgo.com/Tests_(album)",
		"https://duckduckgo.com/test_(Unix)",
		"https://duckduckgo.com/TEST_(x86_instruction)",
		"https://duckduckgo.com/John_Test",
		"https://duckduckgo.com/Zack_Test",
		"https://duckduckgo.com/Proof_test",
		"https://duckduckgo.com/Stress_testing",
		"https://duckduckgo.com/Test_(biology)",
		"https://duckduckgo.com/Test_equipment",
		"https://duckduckgo.com/Test_cricket",
		"https://duckduckgo.com/Test_match_(rugby_league)",
		"https://duckduckgo.com/Test_match_(rugby_union)",
		"https://duckduckgo.com/River_Test",
		"https://duckduckgo.com/Test_(law)",
		"https://duckduckgo.com/Experiment",
		"https://duckduckgo.com/d/.test",
		"https://duckduckgo.com/d/Tester",
		"https://duckduckgo.com/d/The_Test",
		"https://duckduckgo.com/d/Examination",
		"https://duckduckgo.com/d/Trial",
		"https://duckduckgo.com/d/Validation",
		"https://duckduckgo.com/d/Verification"
	]
		
	var stubTexts = [
		"Test cricket The form of the sport of cricket with the longest match duration, and is considered the game\'s...",
		"Test (wrestler) A Canadian professional wrestler and actor.",
		"Test (assessment) An educational assessment intended to measure a test-taker\'s knowledge, skill, aptitude, physical...",
		"Test (2013 film) A 2013 American drama film written and directed by Chris Mason Johnson.",
		"Test (2014 film) A 2014 Russian film about a doomed love triangle, set in 1949 on the prairie of the Kazakh Soviet...",
		"Test (group) A free jazz cooperative.",
		"Tests (album) An album by The Microphones. It was first released as a cassette tape on Knw-Yr-Own in 1998.",
		"test (Unix) A command-line utility found in Unix, Plan 9, and Unix-like operating systems that evaluates...",
		"TEST (x86 instruction) In the x86 assembly language, the TEST instruction performs a bitwise AND on two operands.",
		"John Test A U.S. Representative from Indiana. John Test was born and raised near Salem, New Jersey.",
		"Zack Test A retired American rugby union player who played for the United States national rugby sevens team.",
		"Proof test A form of stress test to demonstrate the fitness of a load-bearing structure.",
		"Stress testing A form of deliberately intense or thorough testing used to determine the stability of a given...",
		"Test (biology) The hard shell of some spherical marine animals, notably sea urchins and microorganisms such as...",
		"Test equipment A general term describing equipment used in many fields. Types of test equipment include...",
		"Test cricket The form of the sport of cricket with the longest match duration, and is considered the game\'s...",
		"Test match (rugby league) A representative match between teams representing members of the Rugby League International...",
		"Test match (rugby union) An international match, usually played between two senior national teams, that is recognised as...",
		"River Test A chalk stream in Hampshire in the south of England.",
		"Test (law) A commonly applied method of evaluation used to resolve matters of jurisprudence.",
		"Experiment A procedure carried out to support, refute, or validate a hypothesis.",
		".test A reserved top-level domain.",
		"Tester Person or device that tests or measures.",
		"The Test See related meanings for the phrase \'The Test\'.",
		"Examination See related meanings for the word \'Examination\'.",
		"Trial See related meanings for the word \'Trial\'.",
		"Validation See related meanings for the word \'Validation\'.",
		"Verification See related meanings for the word \'Verification\'."
	]
}
