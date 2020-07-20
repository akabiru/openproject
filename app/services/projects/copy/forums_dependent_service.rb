#-- encoding: UTF-8

#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2020 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++

module Projects::Copy
  class ForumsDependentService < Dependency
    protected

    def copy_dependency(params:)
      source.forums.find_each do |forum|
        new_forum = Forum.new
        new_forum.attributes = forum.attributes.dup.except('id',
                                                           'project_id',
                                                           'topics_count',
                                                           'messages_count',
                                                           'last_message_id')
        copy_topics(forum, new_forum)

        new_forum.project = target
        target.forums << new_forum
      end
    end

    def copy_topics(board, new_forum)
      topics = board.topics.where('parent_id is NULL')
      topics.each do |topic|
        new_topic = Message.new
        new_topic.attributes = topic.attributes.dup.except('id',
                                                           'forum_id',
                                                           'author_id',
                                                           'replies_count',
                                                           'last_reply_id',
                                                           'created_on',
                                                           'updated_on')
        new_topic.forum = new_forum
        new_topic.author_id = topic.author_id
        new_forum.topics << new_topic
      end
    end
  end
end
