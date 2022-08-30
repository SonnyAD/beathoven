---@diagnostic disable: lowercase-global
local responsive = require "responsive.draw"

local Packet = require "gameobjects.packet"
local Node = require "gameobjects.node"
local Queue = require "../utils.queue"

local PartitionManager = {}

local pool = {}
local usable = {}
local notes = {}

local nodes = {}

local time = 0
local lastIndex = 0

local goodNote = nil
local MissedNote = nil

local playedMusic = false
local started = false

local musicFinishedCallback = nil

function PartitionManager.load(IncreaseScore, decreaseHP, keyA, keyB, keyC, keyD, callback)

    i = 0
    notes[i] = {timestamp=1.3828, target="A"}
    i = i + 1
    notes[i] = {timestamp=1.581511, target="B"}
    i = i + 1
    notes[i] = {timestamp=2.446243-0.69, target="C"}
    i = i + 1
    notes[i] = {timestamp=2.643244-0.69, target="D"}
    i = i + 1
    notes[i] = {timestamp=5.036382-0.69, target="A"}
    i = i + 1
    notes[i] = {timestamp=5.255653-0.69, target="B"}
    i = i + 1
    notes[i] = {timestamp=5.420106-0.69, target="C"}
    i = i + 1
    notes[i] = {timestamp=5.615395-0.69, target="D"}
    i = i + 1

	notes[i] = {timestamp=8.3166666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=8.5166666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=8.7833333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=8.95-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=9.1166666666667-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=9.2833333333334-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=9.45-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=9.6166666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=9.7833333333334-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=9.9833333333334-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=10.416666666667-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=10.783333333333-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=11.25-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=11.55-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=12.25-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=12.416666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=12.616666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=12.75-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=12.983333333334-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=13.983333333334-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=14.15-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=14.316666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=14.516666666667-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=15.55-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=15.716666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=15.883333333334-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=16.05-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=16.983333333334-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=17.15-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=17.283333333334-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=17.483333333334-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=18.15-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=18.316666666667-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=18.683333333334-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=19.05-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=19.183333333334-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=19.416666666667-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=19.583333333334-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=19.783333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=19.916666666667-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=20.116666666667-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=20.25-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=20.55-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=20.983333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=21.383333333333-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=21.816666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=22-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=22.133333333333-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=22.416666666667-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=22.65-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=23.466666666667-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=23.566666666667-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=23.633333333333-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=23.8-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=24.133333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=24.283333333333-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=25.05-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=25.183333333333-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=25.416666666667-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=25.616666666666-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=25.716666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=26.483333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=26.65-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=26.85-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=27.05-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=27.183333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=28.016666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=28.15-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=28.383333333333-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=28.616666666666-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=28.783333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=29.55-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=29.716666666666-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=29.95-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=30.15-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=30.216666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=30.983333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=31.15-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=31.383333333333-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=31.616666666666-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=31.683333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=32.483333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=32.616666666666-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=32.849999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=33.049999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=33.216666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=33.416666666666-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=33.616666666666-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=33.816666666666-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=33.983333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=34.183333333333-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=34.416666666666-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=34.849999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=34.883333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=35.149999999999-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=35.416666666666-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=35.716666666666-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=35.916666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=36.116666666666-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=36.349999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=36.516666666666-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=36.683333333333-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=36.883333333333-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=37.083333333333-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=37.249999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=37.416666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=37.583333333332-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=37.816666666666-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=37.949999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=38.083333333332-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=38.583333333332-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=38.749999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=38.883333333332-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=39.049999999999-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=39.249999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=39.349999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=39.549999999999-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=39.749999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=39.783333333332-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=39.949999999999-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=40.149999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=40.316666666666-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=40.483333333332-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=40.683333333332-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=40.816666666666-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=40.983333333332-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=41.149999999999-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=41.616666666666-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=41.999999999999-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=42.349999999999-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=42.716666666666-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=43.083333333332-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=43.449999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=43.649999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=43.816666666665-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=44.216666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=44.616666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=44.783333333332-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=44.949999999999-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=45.149999999999-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=45.416666666665-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=45.616666666665-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=45.783333333332-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=45.916666666665-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=46.166666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=47.933333333332-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=48.099999999999-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=48.283333333332-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=48.716666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=49.083333333332-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=49.499999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=49.799999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=50.199999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=50.516666666665-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=50.933333333332-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=51.099999999998-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=51.299999999998-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=51.416666666665-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=51.566666666665-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=51.866666666665-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=52.099999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=52.466666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=52.816666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=53.583333333332-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=54.049999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=54.249999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=54.349999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=54.466666666665-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=54.583333333332-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=54.783333333332-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=55.016666666665-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=55.183333333331-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=55.383333333331-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=55.616666666665-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=55.849999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=56.049999999998-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=56.216666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=56.416666666665-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=56.649999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=56.883333333331-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=57.049999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=57.283333333331-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=57.483333333331-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=57.683333333331-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=57.849999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=58.049999999998-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=58.249999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=58.416666666665-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=58.583333333331-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=58.749999999998-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=58.983333333331-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=59.116666666665-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=59.283333333331-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=59.649999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=60.016666666665-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=60.349999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=60.716666666665-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=61.083333333331-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=61.483333333331-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=61.849999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=62.249999999998-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=62.616666666664-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=62.983333333331-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=63.349999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=63.749999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=64.083333333331-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=64.449999999998-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=64.783333333331-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=65.216666666664-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=65.649999999998-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=65.983333333331-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=66.349999999998-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=66.749999999997-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=67.116666666664-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=67.483333333331-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=67.816666666664-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=68.183333333331-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=68.516666666664-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=68.683333333331-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=68.916666666664-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=69.116666666664-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=69.283333333331-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=69.449999999997-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=69.649999999997-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=69.816666666664-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=69.999999999997-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=70.149999999997-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=70.316666666664-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=70.499999999997-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=70.666666666664-0.69, target="A"}
	i = i + 1
	notes[i] = {timestamp=70.833333333331-0.69, target="B"}
	i = i + 1
	notes[i] = {timestamp=71.049999999997-0.69, target="C"}
	i = i + 1
	notes[i] = {timestamp=71.199999999997-0.69, target="D"}
	i = i + 1
	notes[i] = {timestamp=71.283333333331-0.69, target="A"}
	i = i + 1


    nodes["A"] = { node=Node.new(-100, 0, 100, "A"), key=keyA, queue=Queue.new(), active=true }
    nodes["B"] = { node=Node.new(0, -100, 100, "B"), key=keyB, queue=Queue.new(), active=true }
    nodes["C"] = { node=Node.new(100, 0, 100, "C"), key=keyC, queue=Queue.new(), active=true }
    nodes["D"] = { node=Node.new(0, 100, 100, "D"), key=keyD, queue=Queue.new(), active=true }

    goodNote = IncreaseScore
    MissedNote = decreaseHP

    for i = 0,20,1
    do
        pool[i] = Packet.new(0, 0, 0, 0, 1, 1, 1, 10, notes, MissedNote)
        usable[i] = true
    end

    Music = love.audio.newSource("assets/Beethovens 5th Symphony Badass Remix - Nicholas Chazarre.mp3", "static")

	musicFinishedCallback = callback
end

function PartitionManager.update(dt)

    started = true

    if playedMusic == false then
        Music:play()
        playedMusic = true
    end

    -- foreach node
    for k, v in pairs(nodes) do

        -- test if pressed
        if (v.active and love.keyboard.isDown(v.key)) then
            local result = PartitionManager.nodeActivated(k)
            print(v.key..","..time)
            v.node:pressed(result)
            v.active = false
        elseif(not v.active and not love.keyboard.isDown(v.key)) then
            v.active = true
        end

        -- update it
        v.node:update(dt)
    end

    -- selection of the notes that should be played
    local selectedNotes = {}
    local j = 0
    for i = lastIndex,#notes,1
    do
        if time <= notes[i].timestamp and notes[i].timestamp <= time + dt then
            selectedNotes[j] = notes[i].target

            j = j + 1
            lastIndex = i+1
        else
            break
        end
    end

    time = time + dt

    -- assign packets to notes selected
    local l = 0
    local k = 0
    while(l < j)
    do
        if usable[k] then
            -- k  going to selectedNotes[l]
            pool[k]:setTarget(nodes[selectedNotes[l]].node.initialX, nodes[selectedNotes[l]].node.initialY, selectedNotes[l])
            nodes[selectedNotes[l]].queue:enqueue(k)
            usable[k] = false
            l = l + 1
        end
        k = k + 1

        if k >= #pool then
            break
        end
    end

    -- update packets
    for i = 0,#pool,1
    do
        pool[i]:update(dt)
        
        -- Mark arrived packets as usable
        if usable[i] == false and pool[i]:hasArrived() then
            --print("Too late miss")
            nodes[pool[i].target].queue:deleteFirst(i)
            MissedNote()
            nodes[pool[i].target].node:pressed(false)
            usable[i] = true
        end
    end

	if (Music:isPlaying() == false) then
		started = false
		playedMusic = false
		time = 0
		musicFinishedCallback()
	end
end

function PartitionManager.nodeActivated(name)
    --print("Pressed "..name)
    if nodes[name].queue:count() > 0 then
        local packetIndex = nodes[name].queue:dequeue()
        local packet = pool[packetIndex]

        if pool[packetIndex]:hasArrived() == false then
            if nodes[name].node:testOverlap(packet.x, packet.y) then
                packet:arrived(false)
                goodNote()
                --print("Good")
                usable[packetIndex] = true
                return true
            else
                packet:arrived(true)
                MissedNote()
                --print("Early miss")
                usable[packetIndex] = true
            end
        else
            MissedNote()
        end
    end

    return false
end


function PartitionManager.draw()
    if (started == false) then
        return
    end

    -- Lines
    love.graphics.setColor(1/255, 240/255, 254/255, 1)
    responsive.line(-100, 0, 100, 0)
    responsive.line(0, -100, 0, 100)

    -- Nodes
    for k, v in pairs(nodes) do
        v.node:draw()
    end

    -- Packets
    for i = 0,#pool,1
    do 
        pool[i]:draw()
    end
end

return PartitionManager