#-- copyright
# OpenProject is an open source project management software.
# Copyright (C) 2012-2023 the OpenProject GmbH
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
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
# See COPYRIGHT and LICENSE files for more details.
#++

module Components
  module WorkPackages
    class Baseline
      include Capybara::DSL
      include Capybara::RSpecMatchers
      include RSpec::Matchers

      def expect_active
        expect(page).to have_selector('.wp-table--baseline-th')
      end

      def expect_inactive
        expect(page).not_to have_selector('.wp-table--baseline-th')
        expect(page).not_to have_selector('.wp-table--baseline-cell-td')
      end

      def expect_changed(work_package)
        expect_icon(work_package, :changed)
      end

      def expect_added(work_package)
        expect_icon(work_package, :added)
      end

      def expect_removed(work_package)
        expect_icon(work_package, :removed)
      end

      def expect_unchanged(work_package)
        page.within(row_selector(work_package)) do
          expect(page).not_to have_selector(".wp-table--baseline-cell-td *")
        end
      end

      def expect_icon(work_package, icon_type)
        page.within(row_selector(work_package)) do
          expect(page).to have_selector(".op-table-baseline--icon-#{icon_type}")
        end
      end

      def row_selector(elem)
        id = elem.is_a?(WorkPackage) ? elem.id.to_s : elem.to_s
        ".wp-row-#{id}-table"
      end
    end
  end
end
