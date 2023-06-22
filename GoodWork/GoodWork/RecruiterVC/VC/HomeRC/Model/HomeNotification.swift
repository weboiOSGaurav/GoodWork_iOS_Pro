/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct HomeNotification : Codable {
	let status : Int?
	let id : Int?
	let created_by : String?
	let job_id : String?
	let title : String?
	let text : String?
	let created_at : String?
	let updated_at : String?
	let deleted_at : String?
    let created_at_definition : String?
    
	enum CodingKeys: String, CodingKey {

		case status = "status"
		case id = "id"
		case created_by = "created_by"
		case job_id = "job_id"
		case title = "title"
		case text = "text"
		case created_at = "created_at"
		case updated_at = "updated_at"
		case deleted_at = "deleted_at"
        case created_at_definition = "created_at_definition"
        
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		created_by = try values.decodeIfPresent(String.self, forKey: .created_by)
		job_id = try values.decodeIfPresent(String.self, forKey: .job_id)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		text = try values.decodeIfPresent(String.self, forKey: .text)
		created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
		updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
		deleted_at = try values.decodeIfPresent(String.self, forKey: .deleted_at)
        created_at_definition = try values.decodeIfPresent(String.self, forKey: .created_at_definition)
        
	}

}
