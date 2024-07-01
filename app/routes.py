from flask import Blueprint, jsonify, request

main = Blueprint('main', __name__)

notes = [
    {"id": 1, "content": "This is a note"}
]

@main.route('/notes', methods=['GET'])
def get_notes():
    return jsonify(notes)

@main.route('/notes/<int:note_id>', methods=['GET'])
def get_note(note_id):
    note = next((note for note in notes if note['id'] == note_id), None)
    return jsonify(note) if note else ('', 404)

@main.route('/notes', methods=['POST'])
def add_note():
    if request.is_json:
        note = request.get_json()
        note['id'] = len(notes) + 1
        notes.append(note)
        return note, 201
    return {'error': 'Request must be JSON'}, 400

@main.route('/notes/<int:note_id>', methods=['PUT'])
def update_note(note_id):
    note = next((note for note in notes if note['id'] == note_id), None)
    if note:
        data = request.get_json()
        note['content'] = data['content']
        return jsonify(note)
    return {'error': 'Note not found'}, 404